"""ゲーとも！配布用アプリアイコン（1024px）を作るスクリプト。
Pillow でフラットデザインのゲームコントローラー（Dパッド＋ABボタン）を描く。生成物:
  - app/assets/icon/app_icon.png      （flutter_launcher_icons のソース）
"""
from PIL import Image, ImageDraw

SIZE = 1024
BG = (232, 236, 242)        # ライトグレー（シリーズ共通の落ち着いた背景色）
BODY = (250, 250, 250)      # コントローラー本体（白）
EDGE = (46, 58, 74)         # 本体の縁・影（ダークネイビー）
GREEN = (39, 143, 90)       # Dパッド（シリーズ緑）
RED = (239, 68, 68)         # Aボタン
YELLOW = (245, 158, 11)     # Bボタン


def rounded(im, radius):
    mask = Image.new("L", im.size, 0)
    d = ImageDraw.Draw(mask)
    d.rounded_rectangle([0, 0, SIZE - 1, SIZE - 1], radius=radius, fill=255)
    out = Image.new("RGBA", im.size, (0, 0, 0, 0))
    out.paste(im, (0, 0), mask)
    return out


def _pad_silhouette(d, color):
    # 中央の角丸長方形と左右のグリップ（楕円）を重ねた1枚のシルエット
    d.rounded_rectangle([232, 330, 512, 690], radius=160, fill=color)
    d.rounded_rectangle([512, 342, 792, 678], radius=160, fill=color)
    d.ellipse([192, 330, 412, 706], fill=color)
    d.ellipse([612, 330, 832, 706], fill=color)


def draw_pad():
    im = Image.new("RGBA", (SIZE, SIZE), (0, 0, 0, 0))
    d = ImageDraw.Draw(im)

    # 背景（角丸ライトグレー）
    d.rounded_rectangle([0, 0, SIZE - 1, SIZE - 1], radius=192, fill=BG + (255,))

    # 影→本体
    pad_shadow = im.copy()
    d2 = ImageDraw.Draw(pad_shadow)
    _pad_silhouette(d2, EDGE + (255,))
    pad_shadow = pad_shadow.resize((SIZE + 24, SIZE + 24)).resize((SIZE, SIZE))
    im.alpha_composite(pad_shadow, (12, 14))

    pad_body = Image.new("RGBA", (SIZE, SIZE), (0, 0, 0, 0))
    d3 = ImageDraw.Draw(pad_body)
    _pad_silhouette(d3, BODY + (255,))
    im.alpha_composite(pad_body, (0, 0))

    # Dパッド（左側の緑十字）
    cx, cy = 382, 508
    d.rounded_rectangle([cx - 26, cy - 104, cx + 26, cy + 104], radius=18, fill=GREEN + (255,))
    d.rounded_rectangle([cx - 104, cy - 26, cx + 104, cy + 26], radius=18, fill=GREEN + (255,))

    # ABボタン（右側の赤・黄ペア）
    d.ellipse([568, 440, 638, 510], fill=RED + (255,))
    d.ellipse([668, 494, 738, 564], fill=YELLOW + (255,))

    return im


if __name__ == "__main__":
    im = draw_pad()
    im = rounded(im, 192)
    out = r"..\app\assets\icon\app_icon.png"
    im.save(out)
    print("saved:", out)

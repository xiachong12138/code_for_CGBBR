import matplotlib.pyplot as plt
import matplotlib.font_manager as fm

# 获取系统中所有的字体文件路径
font_paths = fm.findSystemFonts()

# 打印所有字体文件路径
for font_path in font_paths:
    print(font_path)

# 设置字体
font = fm.FontProperties(fname=font_paths[0])

# 创建图形并显示文字
fig, ax = plt.subplots()
ax.text(0.5, 0.5, "Hello, world!", fontproperties=font, fontsize=20)
plt.show()

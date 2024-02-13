From: Rob Herring <robh@kernel.org>
Date: Tue, 13 Feb 2024 19:35:13 -0000
Subject: [PATCH 0/6] dts: Fix dtc interrupt warnings
Message-ID: <20240213-arm-dt-cleanups-v1-0-f2dee1292525@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

I had a branch with most of these changes sitting in my tree for some 
time. Geert's asking about some errors not getting found prompted me to 
clean it up and send it out. This series fixes all* interrupt related 
warnings and enables the check by default. 

SoC maintainers, Can you please take this series directly. 

Rob

*There's a few Renesas warnings still Geert said he would fix.

Signed-off-by: Rob Herring <robh@kernel.org>
---
Rob Herring (6):
      arm64: dts: freescale: Disable interrupt_map check
      arm: dts: Fix dtc interrupt_provider warnings
      arm64: dts: Fix dtc interrupt_provider warnings
      arm: dts: Fix dtc interrupt_map warnings
      arm64: dts: qcom: Fix interrupt-map cell sizes
      dtc: Enable dtc interrupt_provider check

 arch/arm/boot/dts/amazon/alpine.dtsi                  |  1 -
 arch/arm/boot/dts/aspeed/aspeed-g4.dtsi               | 14 --------------
 arch/arm/boot/dts/aspeed/aspeed-g5.dtsi               | 15 +--------------
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi               | 18 ++----------------
 arch/arm/boot/dts/broadcom/bcm-cygnus.dtsi            |  3 +++
 arch/arm/boot/dts/broadcom/bcm-hr2.dtsi               |  1 +
 arch/arm/boot/dts/broadcom/bcm-nsp.dtsi               |  2 ++
 .../boot/dts/intel/ixp/intel-ixp42x-gateway-7001.dts  |  2 ++
 .../dts/intel/ixp/intel-ixp42x-goramo-multilink.dts   |  2 ++
 arch/arm/boot/dts/marvell/kirkwood-l-50.dts           |  2 ++
 arch/arm/boot/dts/nuvoton/nuvoton-wpcm450.dtsi        |  2 ++
 arch/arm/boot/dts/nvidia/tegra30-apalis-v1.1.dtsi     |  1 -
 arch/arm/boot/dts/nvidia/tegra30-apalis.dtsi          |  1 -
 arch/arm/boot/dts/nvidia/tegra30-colibri.dtsi         |  1 -
 arch/arm/boot/dts/nxp/imx/imx6q-b850v3.dts            |  3 ---
 arch/arm/boot/dts/nxp/imx/imx6q-bx50v3.dtsi           |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi         |  1 -
 arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi        |  1 -
 arch/arm/boot/dts/nxp/imx/imx6qdl-emcon.dtsi          |  1 -
 arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-pfla02.dtsi  |  1 +
 .../boot/dts/nxp/imx/imx6qdl-phytec-phycore-som.dtsi  |  1 +
 arch/arm/boot/dts/nxp/imx/imx7d-pico-dwarf.dts        |  1 +
 arch/arm/boot/dts/nxp/vf/vf610-zii-dev-rev-b.dts      |  1 +
 arch/arm/boot/dts/qcom/qcom-sdx55.dtsi                |  8 ++++----
 arch/arm/boot/dts/st/stm32429i-eval.dts               |  1 -
 arch/arm/boot/dts/st/stm32mp157c-dk2.dts              |  1 -
 arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts     |  1 -
 arch/arm64/boot/dts/amazon/alpine-v2.dtsi             |  1 -
 arch/arm64/boot/dts/amazon/alpine-v3.dtsi             |  1 -
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi      |  1 +
 arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi   |  1 +
 arch/arm64/boot/dts/freescale/Makefile                | 19 +++++++++++++++++++
 arch/arm64/boot/dts/lg/lg1312.dtsi                    |  1 -
 arch/arm64/boot/dts/lg/lg1313.dtsi                    |  1 -
 arch/arm64/boot/dts/marvell/armada-ap80x.dtsi         |  1 -
 arch/arm64/boot/dts/mediatek/mt8195-demo.dts          |  1 +
 arch/arm64/boot/dts/qcom/ipq6018.dtsi                 |  8 ++++----
 arch/arm64/boot/dts/qcom/ipq8074.dtsi                 | 16 ++++++++--------
 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi              |  4 ++++
 scripts/Makefile.lib                                  |  3 +--
 40 files changed, 65 insertions(+), 81 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240213-arm-dt-cleanups-76bb726de948

Best regards,
-- 
Rob Herring <robh@kernel.org>


From: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Date: Mon, 7 Mar 2022 16:37:40 -0800
Subject: [PATCH 0/5] Fix AST2600 quad mode SPI pinmux settings
Message-ID: <20220308003745.3930607-1-quic_jaehyoo@quicinc.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

I?m sending this patch series to fix current issues in AST2600 pinmux
settings while enabling quad mode SPI support.

FWSPI18 pins are basically 1.8v logic pins that are different from the
dedicated FWSPI pins that provide 3.3v logic level, so FWSPI18 pins can?t
be grouped with FWSPIDQ2 and FWSPIDQ3, so this series fix the issue.

Also, fixes QSPI1 and QSPI2 function settings in AST2600 pinctrl dtsi to
make it able to enable quad mode on SPI1 and SPI2 interfaces.

With this series, quad mode pinmux can be set like below.

FW SPI:
&fmc {
	pinctrl-names = "default";
	pinctrl-0 = <&pinctrl_fwqspi_default>;
}

SPI1:
&spi1 {
	pinctrl-names = "default";
	pinctrl-0 = <&pinctrl_qspi1_default>;
}

SPI2:
&spi1 {
	pinctrl-names = "default";
	pinctrl-0 = <&pinctrl_qspi1_default>;
}

Please review.

Thanks,
Jae


Jae Hyun Yoo (3):
  ARM: dts: aspeed-g6: remove FWQSPID group in pinctrl dtsi
  pinctrl: pinctrl-aspeed-g6: remove FWQSPID group in pinctrl dtsi
  ARM: dts: aspeed-g6: fix SPI1/SPI2 quad pin group

Johnny Huang (2):
  pinctrl: pinctrl-aspeed-g6: add FWQSPI function-group
  ARM: dts: aspeed-g6: add FWQSPI group in pinctrl dtsi

 arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi   | 10 +++++-----
 drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c | 17 ++++++++---------
 2 files changed, 13 insertions(+), 14 deletions(-)

-- 
2.25.1


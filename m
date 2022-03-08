From: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Date: Mon, 7 Mar 2022 16:37:44 -0800
Subject: [PATCH 4/5] ARM: dts: aspeed-g6: add FWQSPI group in pinctrl dtsi
In-Reply-To: <20220308003745.3930607-1-quic_jaehyoo@quicinc.com>
References: <20220308003745.3930607-1-quic_jaehyoo@quicinc.com>
Message-ID: <20220308003745.3930607-5-quic_jaehyoo@quicinc.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Johnny Huang <johnny_huang@aspeedtech.com>

Add FWSPIDQ2 and FWSPIDQ3 group to support AST2600 FW SPI quad mode.
These pins can be used with dedicated FW SPI pins - FWSPICS0#,
FWSPICK, FWSPIMOSI and FWSPIMISO.

Signed-off-by: Johnny Huang <johnny_huang@aspeedtech.com>
Signed-off-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
---
 arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi b/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi
index 06d60a8540e9..47c3fb137cbc 100644
--- a/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi
@@ -117,6 +117,11 @@ pinctrl_fwspid_default: fwspid_default {
 		groups = "FWSPID";
 	};
 
+	pinctrl_fwqspi_default: fwqspi_default {
+		function = "FWQSPI";
+		groups = "FWQSPI";
+	};
+
 	pinctrl_fwspiwp_default: fwspiwp_default {
 		function = "FWSPIWP";
 		groups = "FWSPIWP";
-- 
2.25.1


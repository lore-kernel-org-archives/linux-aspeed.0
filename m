From: Thang Nguyen OS <thang@amperemail.onmicrosoft.com>
Date: Tue, 14 Feb 2023 04:02:07 +0000
Subject: [PATCH] ARM: dts: aspeed: mtjade: Add SMPro nodes
In-Reply-To: <20221118065109.2339066-1-quan@os.amperecomputing.com>
References: <20221118065109.2339066-1-quan@os.amperecomputing.com>
Message-ID: <32FE8D60-98AF-4134-8FB0-46B0CE7CA420@amperemail.onmicrosoft.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 18 Nov 2022, at 13:51, Quan Nguyen OS <quan@os.amperecomputing.com> wrote:

Add SMPro nodes to Mt. Jade BMC.

Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
---
arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts | 8 ++++++++
1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
index 353359822d7b..0a51d2e32fab 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
@@ -354,6 +354,14 @@ &i2c1 {

&i2c2 {
status = "okay";
+ smpro at 4f {
+ compatible = "ampere,smpro";
+ reg = <0x4f>;
+ };
+ smpro at 4e {
+ compatible = "ampere,smpro";
+ reg = <0x4e>;
+ };
};

&i2c3 {
--
2.35.1

Hi Joel,
Can you also pick https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=7c07553807c5125c89de242d35c10c206fd8e6bb to fix USB gadget issue? It is to support multiple devices (i.e. virtual media, USB Ethernet, ?) at the same time?

Thanks,
Thang Q. Nguyen
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230214/c9b808c5/attachment.htm>

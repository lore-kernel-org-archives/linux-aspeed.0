From: Vijay Khemka <vijaykhemka@fb.com>
Date: Fri, 30 Oct 2020 06:16:23 +0000
Subject: [PATCH] ARM: dts: aspeed: tiogapass: Remove vuart
In-Reply-To: <20200813190431.3331026-1-vijaykhemka@fb.com>
References: <20200813190431.3331026-1-vijaykhemka@fb.com>
Message-ID: <6E9E8073-F918-4BBE-A41D-F0602A363CF4@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Joel,
A quick reminder, can you please merge this patch in your next release.

Regards
-Vijay

?On 8/13/20, 12:04 PM, "Vijay Khemka" <vijaykhemka@fb.com> wrote:

    Removed vuart for facebook tiogapass platform as it uses uart2 and
    uart3 pin with aspeed uart routing feature.

    Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
    ---
     arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts | 5 -----
     1 file changed, 5 deletions(-)

    diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
    index 2d44d9ad4e40..e6ad821a8635 100644
    --- a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
    +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
    @@ -82,11 +82,6 @@ &lpc_ctrl {
     	status = "okay";
     };

    -&vuart {
    -	// VUART Host Console
    -	status = "okay";
    -};
    -
     &uart1 {
     	// Host Console
     	status = "okay";
    -- 
    2.24.1



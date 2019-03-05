From: Vijay Khemka <vijaykhemka@fb.com>
Date: Tue, 5 Mar 2019 20:01:02 +0000
Subject: [PATCH] ARM: dts: aspeed: tiogapass: Enable VUART
In-Reply-To: <20190130181427.2469674-1-vijaykhemka@fb.com>
References: <20190130181427.2469674-1-vijaykhemka@fb.com>
Message-ID: <DAA424C9-E096-40A3-8287-CE4C8E9ABD61@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Please review below patch.

Regards
-Vijay

?On 1/30/19, 10:14 AM, "Vijay Khemka" <vijaykhemka@fb.com> wrote:

    Enabling vuart for Facebook tiogapass
    
    Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
    ---
     arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts | 5 +++++
     1 file changed, 5 insertions(+)
    
    diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
    index 42e0d7a8e8d0..a058fb2985f7 100644
    --- a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
    +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
    @@ -64,6 +64,11 @@
     	status = "okay";
     };
     
    +&vuart {
    +	// VUART Host Console
    +	status = "okay";
    +};
    +
     &uart1 {
     	// Host Console
     	status = "okay";
    -- 
    2.17.1
    
    


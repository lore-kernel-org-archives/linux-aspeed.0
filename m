From: Vijay Khemka <vijaykhemka@fb.com>
Date: Wed, 3 Apr 2019 22:32:04 +0000
Subject: [PATCH] ARM: dts: aspeed: tiogapass: Enable VUART
In-Reply-To: <24375A52-CC8E-4CFE-A683-0720B60D1201@fb.com>
References: <24375A52-CC8E-4CFE-A683-0720B60D1201@fb.com>
Message-ID: <CY4PR15MB1269927DE5C991C43BAF025CDD570@CY4PR15MB1269.namprd15.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Joel,
Please apply this patch to kernel 5.0.

Regards
-Vijay

?On 3/18/19, 12:46 PM, "openbmc on behalf of Vijay Khemka" <openbmc-bounces+vijaykhemka=fb.com at lists.ozlabs.org on behalf of vijaykhemka@fb.com> wrote:

    Hi Joel,
    Please apply this patch.

    Regards
    -Vijay

    On 3/5/19, 12:06 PM, "openbmc on behalf of Vijay Khemka" <openbmc-bounces+vijaykhemka=fb.com at lists.ozlabs.org on behalf of vijaykhemka@fb.com> wrote:

        Please review below patch.

        Regards
        -Vijay

        On 1/30/19, 10:14 AM, "Vijay Khemka" <vijaykhemka@fb.com> wrote:

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
            +   // VUART Host Console
            +   status = "okay";
            +};
            +
             &uart1 {
                // Host Console
                status = "okay";
            --
            2.17.1







-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20190403/4f4dbf0a/attachment.htm>

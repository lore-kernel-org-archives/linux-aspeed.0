From: Zev Weiss <zweiss@equinix.com>
Date: Tue, 27 Sep 2022 01:51:31 +0000
Subject: [PATCH v5] ARM: dts: aspeed: Yosemite V2: Enable OCP debug card
In-Reply-To: <20220926124313.GA8400@hcl-ThinkPad-T495>
References: <20220926124313.GA8400@hcl-ThinkPad-T495>
Message-ID: <20220927015130.GG30806@packtop>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Sep 26, 2022 at 05:43:13AM PDT, Karthikeyan Pasupathi wrote:
>Added IPMB-13 channel for Debug Card communication.
>which improves the readability of the machine and makes
>it easier to debug the server and it will display some
>pieces of information about the server like "system info",
>"Critical sensors" and "critical sel".
>
>---
>--- v5- Updated commit message
>--- v4- Resolved syntax error
>--- v3- Updated the title and commit
>--- v2- Updated the title
>--- v1- Initial draft
>---
>

Note that git treats a '---' line as a separator, so everything past the
first one above will be discarded when this patch is applied (e.g. via
'git am')...

>Signed-off-by: Karthikeyan Pasupathi <pkarthikeyan1509@gmail.com>

...including your S-O-B line here.

If you're aiming to do something like what Joel describes on his blog
(https://shenki.github.io/git-patch-workflow/), you should make sure put
your first '---' line and any non-commit-message notes *after* your
S-O-B and any other tags.

>---
> arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts | 11 +++++++++++
> 1 file changed, 11 insertions(+)
>
>diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
>index 8864e9c312a8..84236df522dc 100644
>--- a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
>+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
>@@ -215,6 +215,17 @@
> 	};
> };
>
>+&i2c13 {
>+	status = "okay";
>+	// Debug Card
>+	multi-master;
>+	ipmb13 at 10 {
>+		compatible = "ipmb-dev";
>+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
>+		i2c-protocol;
>+	};
>+};
>+
> &pwm_tacho {
> 	status = "okay";
> 	//FSC
>-- 
>2.17.1
>

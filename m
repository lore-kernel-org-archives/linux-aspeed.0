From: Bagas Sanjaya <bagasdotme@gmail.com>
Date: Wed, 23 Nov 2022 15:45:46 +0700
Subject: [v4 5/5] hwmon: Add Aspeed ast2600 TACH support
In-Reply-To: <20221123061635.32025-6-billy_tsai@aspeedtech.com>
References: <20221123061635.32025-1-billy_tsai@aspeedtech.com>
 <20221123061635.32025-6-billy_tsai@aspeedtech.com>
Message-ID: <Y33duvUVQ0AJsgAv@debian.me>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Nov 23, 2022 at 02:16:35PM +0800, Billy Tsai wrote:
> diff --git a/Documentation/hwmon/tach-aspeed-ast2600.rst b/Documentation/hwmon/tach-aspeed-ast2600.rst
> new file mode 100644
> index 000000000000..4f9501b783a1
> --- /dev/null
> +++ b/Documentation/hwmon/tach-aspeed-ast2600.rst
> @@ -0,0 +1,24 @@
> +Kernel driver tach-aspeed-ast2600
> +==============================
> +
> +Supported chips:
> +	ASPEED AST2600
> +
> +Authors:
> +	<billy_tsai@aspeedtech.com>
> +
> +Description:
> +------------
> +This driver implements support for ASPEED AST2600 Fan Tacho controller.
> +The controller supports up to 16 tachometer inputs.
> +
> +The driver provides the following sensor accesses in sysfs:
> +=============== ======= =====================================================
> +fanX_input	ro	provide current fan rotation value in RPM as reported
> +			by the fan to the device.
> +fanX_div	rw	Fan divisor: Supported value are power of 4 (1, 4, 16
> +                        64, ... 4194304)
> +                        The larger divisor, the less rpm accuracy and the less
> +                        affected by fan signal glitch.
> +fanX_pulses	rw      Fan pulses per resolution.
> +=============== ======= ======================================================

I found htmldocs warnings:

Documentation/hwmon/tach-aspeed-ast2600.rst:2: WARNING: Title underline too short.

Kernel driver tach-aspeed-ast2600
==============================
Documentation/hwmon/tach-aspeed-ast2600.rst:18: WARNING: Unexpected indentation.
Documentation/hwmon/tach-aspeed-ast2600.rst:19: WARNING: Block quote ends without a blank line; unexpected unindent.
Documentation/hwmon/tach-aspeed-ast2600.rst:23: WARNING: Definition list ends without a blank line; unexpected unindent.

I have applied the fixup:

---- >8 ----

diff --git a/Documentation/hwmon/tach-aspeed-ast2600.rst b/Documentation/hwmon/tach-aspeed-ast2600.rst
index 4f9501b783a11b..8faa00f6ad47c2 100644
--- a/Documentation/hwmon/tach-aspeed-ast2600.rst
+++ b/Documentation/hwmon/tach-aspeed-ast2600.rst
@@ -1,5 +1,5 @@
 Kernel driver tach-aspeed-ast2600
-==============================
+=================================
 
 Supported chips:
 	ASPEED AST2600
@@ -13,7 +13,8 @@ This driver implements support for ASPEED AST2600 Fan Tacho controller.
 The controller supports up to 16 tachometer inputs.
 
 The driver provides the following sensor accesses in sysfs:
-=============== ======= =====================================================
+
+=============== ======= ======================================================
 fanX_input	ro	provide current fan rotation value in RPM as reported
 			by the fan to the device.
 fanX_div	rw	Fan divisor: Supported value are power of 4 (1, 4, 16

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20221123/d33a0bd8/attachment-0001.sig>

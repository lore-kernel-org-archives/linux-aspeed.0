From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Date: Wed, 17 Apr 2019 06:46:18 -0300
Subject: [PATCH v3 10/21] docs: hwmon: aspeed-pwm-tacho: convert to ReST format
In-Reply-To: <cover.1555494108.git.mchehab+samsung@kernel.org>
References: <cover.1555494108.git.mchehab+samsung@kernel.org>
Message-ID: <8461d6c50972d2e5ec90d71e3db18ac2f7edf455.1555494108.git.mchehab+samsung@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Convert aspeed-pwm-tacho to ReST format, in order to allow it to
be parsed by Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/hwmon/aspeed-pwm-tacho | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/hwmon/aspeed-pwm-tacho b/Documentation/hwmon/aspeed-pwm-tacho
index 7cfb34977460..6dcec845fbc7 100644
--- a/Documentation/hwmon/aspeed-pwm-tacho
+++ b/Documentation/hwmon/aspeed-pwm-tacho
@@ -15,8 +15,10 @@ controller supports up to 16 tachometer inputs.
 
 The driver provides the following sensor accesses in sysfs:
 
+=============== ======= =====================================================
 fanX_input	ro	provide current fan rotation value in RPM as reported
 			by the fan to the device.
 
 pwmX		rw	get or set PWM fan control value. This is an integer
 			value between 0(off) and 255(full speed).
+=============== ======= =====================================================
-- 
2.20.1


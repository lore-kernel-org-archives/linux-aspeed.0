From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 24 Mar 2022 17:59:17 +0100
Subject: [PATCH 2/3] Documentation/ABI: sysfs-class-thermal: Fix Sphinx warning
In-Reply-To: <20220324165918.22005-1-hdegoede@redhat.com>
References: <20220324165918.22005-1-hdegoede@redhat.com>
Message-ID: <20220324165918.22005-3-hdegoede@redhat.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Fix the following warning from "make htmldocs":

Documentation/ABI/testing/sysfs-class-thermal:201:
  WARNING: Bullet list ends without a blank line; unexpected unindent.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/ABI/testing/sysfs-class-thermal | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-thermal b/Documentation/ABI/testing/sysfs-class-thermal
index 2c52bb1f864c..8eee37982b2a 100644
--- a/Documentation/ABI/testing/sysfs-class-thermal
+++ b/Documentation/ABI/testing/sysfs-class-thermal
@@ -203,7 +203,7 @@ Description:
 
 		- for generic ACPI: should be "Fan", "Processor" or "LCD"
 		- for memory controller device on intel_menlow platform:
-		should be "Memory controller".
+		  should be "Memory controller".
 
 		RO, Required
 
-- 
2.35.1


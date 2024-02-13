From: Rob Herring <robh@kernel.org>
Date: Tue, 13 Feb 2024 19:35:26 -0000
Subject: [PATCH 6/6] dtc: Enable dtc interrupt_provider check
In-Reply-To: <20240213-arm-dt-cleanups-v1-0-f2dee1292525@kernel.org>
References: <20240213-arm-dt-cleanups-v1-0-f2dee1292525@kernel.org>
Message-ID: <20240213-arm-dt-cleanups-v1-6-f2dee1292525@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Now that all the interrupt warnings have been fixed, enable
'interrupt_provider' check by default. This will also enable
'interrupt_map' check.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 scripts/Makefile.lib | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index cd5b181060f1..fce35e4657f5 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -340,7 +340,7 @@ quiet_cmd_gzip = GZIP    $@
 # DTC
 # ---------------------------------------------------------------------------
 DTC ?= $(objtree)/scripts/dtc/dtc
-DTC_FLAGS += -Wno-interrupt_provider \
+DTC_FLAGS += \
 	-Wno-unique_unit_address
 
 # Disable noisy checks by default
@@ -358,7 +358,6 @@ endif
 ifneq ($(findstring 2,$(KBUILD_EXTRA_WARN)),)
 DTC_FLAGS += -Wnode_name_chars_strict \
 	-Wproperty_name_chars_strict \
-	-Winterrupt_provider \
 	-Wunique_unit_address
 endif
 

-- 
2.43.0


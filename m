From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Tue, 30 Jul 2024 14:44:34 -0000
Subject: [PATCH 2/5] x86/mm: add testmmiotrace MODULE_DESCRIPTION()
In-Reply-To: <20240730-module_description_orphans-v1-0-7094088076c8@quicinc.com>
References: <20240730-module_description_orphans-v1-0-7094088076c8@quicinc.com>
Message-ID: <20240730-module_description_orphans-v1-2-7094088076c8@quicinc.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Fix the following 'make W=1' warning:

WARNING: modpost: missing MODULE_DESCRIPTION() in arch/x86/mm/testmmiotrace.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 arch/x86/mm/testmmiotrace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/mm/testmmiotrace.c b/arch/x86/mm/testmmiotrace.c
index bda73cb7a044..ae295659ca14 100644
--- a/arch/x86/mm/testmmiotrace.c
+++ b/arch/x86/mm/testmmiotrace.c
@@ -144,3 +144,4 @@ static void __exit cleanup(void)
 module_init(init);
 module_exit(cleanup);
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Test module for mmiotrace");

-- 
2.42.0


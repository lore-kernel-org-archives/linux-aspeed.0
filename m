From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 24 Mar 2022 17:59:18 +0100
Subject: [PATCH 3/3] Documentation/ABI: sysfs-fs-erofs: Fix Sphinx errors
In-Reply-To: <20220324165918.22005-1-hdegoede@redhat.com>
References: <20220324165918.22005-1-hdegoede@redhat.com>
Message-ID: <20220324165918.22005-4-hdegoede@redhat.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Fix the following warnings from "make htmldocs":

Documentation/ABI/testing/sysfs-fs-erofs:10:
  ERROR: Unexpected indentation.
  WARNING: Block quote ends without a blank line; unexpected unindent.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/ABI/testing/sysfs-fs-erofs | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
index 05482374a741..bb4681a01811 100644
--- a/Documentation/ABI/testing/sysfs-fs-erofs
+++ b/Documentation/ABI/testing/sysfs-fs-erofs
@@ -9,8 +9,9 @@ Description:	Shows all enabled kernel features.
 What:		/sys/fs/erofs/<disk>/sync_decompress
 Date:		November 2021
 Contact:	"Huang Jianan" <huangjianan@oppo.com>
-Description:	Control strategy of sync decompression
+Description:	Control strategy of sync decompression:
+
 		- 0 (default, auto): enable for readpage, and enable for
-				     readahead on atomic contexts only,
+		  readahead on atomic contexts only.
 		- 1 (force on): enable for readpage and readahead.
 		- 2 (force off): disable for all situations.
-- 
2.35.1


From: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
Date: Wed, 10 Apr 2019 17:24:24 +0200
Subject: [PATCH 21/21] docs: hwmon: Add an index file and rename docs to
 *.rst
In-Reply-To: <5ac1fbc7f19192dcd30a184e62e3f7989a5437a4.1554893882.git.mchehab+samsung@kernel.org>
References: <cover.1554893881.git.mchehab+samsung@kernel.org>
 <5ac1fbc7f19192dcd30a184e62e3f7989a5437a4.1554893882.git.mchehab+samsung@kernel.org>
Message-ID: <20190410152424.GA11536@latitude>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

On Wed, Apr 10, 2019 at 08:12:11AM -0300, Mauro Carvalho Chehab wrote:
> Now that all files were converted to ReST format, rename them
> and add an index.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
[...]
> diff --git a/Documentation/hwmon/submitting-patches b/Documentation/hwmon/submitting-patches.rst
> similarity index 99%
> rename from Documentation/hwmon/submitting-patches
> rename to Documentation/hwmon/submitting-patches.rst
> index 12540b7d9b50..6120db7556aa 100644
> --- a/Documentation/hwmon/submitting-patches
> +++ b/Documentation/hwmon/submitting-patches.rst

I'd additionally suggest:

diff --git a/Documentation/hwmon/submitting-patches b/Documentation/hwmon/submitting-patches.rst
index f88221b46153..0000a86be4b9 100644
--- a/Documentation/hwmon/submitting-patches
+++ b/Documentation/hwmon/submitting-patches.rst
@@ -38,7 +38,7 @@ increase the chances of your change being accepted.
 2. Adding functionality to existing drivers
 -------------------------------------------
 
-* Make sure the documentation in Documentation/hwmon/<driver_name> is up to
+* Make sure the documentation in Documentation/hwmon/<driver_name>.rst is up to
   date.
 
 * Make sure the information in Kconfig is up to date.
@@ -60,7 +60,7 @@ increase the chances of your change being accepted.
 
 * Consider adding yourself to MAINTAINERS.
 
-* Document the driver in Documentation/hwmon/<driver_name>.
+* Document the driver in Documentation/hwmon/<driver_name>.rst.
 
 * Add the driver to Kconfig and Makefile in alphabetical order.
 

Thanks,
Jonathan Neusch?fer
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20190410/8e2783fe/attachment-0001.sig>

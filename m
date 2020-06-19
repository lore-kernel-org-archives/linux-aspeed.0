From: Milton Miller II <miltonm@us.ibm.com>
Date: Fri, 19 Jun 2020 18:09:55 +0000
Subject: [PATCH v4] hwmon:(adm1275) Enable adm1278 ADM1278_TEMP1_EN
In-Reply-To: <20200619165154.GA20461@cnn>
References: <20200619165154.GA20461@cnn>
Message-ID: <OFB20C104E.283BBF6D-ON0025858C.0062CC5B-0025858C.0063C8F2@notes.na.collabserv.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On : 06/19/2020 abiout 12:46PM in some timezone,  Manikandan Elumalai  wrote:

>The adm1278 temp attribute need it for openbmc platform .
>This feature not enabled by default, so PMON_CONFIG needs to enable
>it.
>
>Signed-off-by: Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
>---
>---    v4 -Reported-by: kernel test robot <lkp@intel.com>

Thie above tag should be Adjacent to the Signed-off-by.

>---    v3 -fix invalid signed-off.
>---       -removed checkpath warnings.
>---       -write ADM1278_TEMP1_EN and ADM1278_VOUT_EN conf in single
>line operation.
>---    v2 -add Signed-off-by.
>---       -removed ADM1278_TEMP1_EN check.
>---

The canonical format is to have a line of 3 dashes then the trailing changelog 

Please read the documentation at 

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#the-canonical-patch-format

milton


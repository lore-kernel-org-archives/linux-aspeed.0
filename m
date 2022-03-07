From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Mon, 7 Mar 2022 15:32:10 +0700
Subject: [PATCH v6 6/9] misc: smpro-errmon: Add Ampere's SMpro error
 monitor driver
In-Reply-To: <YcWFrCjWSG65KQgb@kroah.com>
References: <20211224041352.29405-1-quan@os.amperecomputing.com>
 <20211224041352.29405-7-quan@os.amperecomputing.com>
 <YcWFrCjWSG65KQgb@kroah.com>
Message-ID: <ab8c96a9-b064-f96b-9062-095ff8635ec5@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 24/12/2021 15:32, Greg Kroah-Hartman wrote:
> On Fri, Dec 24, 2021 at 11:13:49AM +0700, Quan Nguyen wrote:
>> This commit adds Ampere's SMpro error monitor driver for monitoring
>> and reporting RAS-related errors as reported by SMpro co-processor
>> found on Ampere's Altra processor family.
>>
>> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
>> ---
>> Change in v6:
>>    + First introduced in v6 [Quan]
>>
>>   drivers/mfd/smpro-mfd.c     |   1 +
>>   drivers/misc/Kconfig        |   7 +
>>   drivers/misc/Makefile       |   1 +
>>   drivers/misc/smpro-errmon.c | 571 ++++++++++++++++++++++++++++++++++++
>>   4 files changed, 580 insertions(+)
>>   create mode 100644 drivers/misc/smpro-errmon.c
> 
> You need Documentation/ABI/ updates when you add sysfs files.  Please do
> that for your next version of this patch.
> 

Thanks greg for the review,
Will update Documentation/ABI/testing/sysfs-* file in next version.

> Also remember that sysfs is only "one value per file", this driver seems
> to violate that in huge ways and is not ok.
> 

These sysfs's does not return "multi value per file" but a single record 
of data, one example is to return the 48-byte ARM RAS Vendor specific 
error record.

Thanks
- Quan

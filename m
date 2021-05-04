From: Randy Dunlap <rdunlap@infradead.org>
Date: Mon, 3 May 2021 22:07:53 -0700
Subject: [PATCH] EDAC: aspeed: print resource_size_t using %pa
In-Reply-To: <e899781c-304c-4494-a544-e3950e928e55@www.fastmail.com>
References: <20210503163409.31944-1-rdunlap@infradead.org>
 <e899781c-304c-4494-a544-e3950e928e55@www.fastmail.com>
Message-ID: <892dfd15-a8f7-9db9-86bb-9630e88e0e3c@infradead.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 5/3/21 9:57 PM, Andrew Jeffery wrote:
> 
> 
> On Tue, 4 May 2021, at 02:04, Randy Dunlap wrote:
>> Fix build warnings for using "%x" to print resource_size_t in 2 places.
>> resource_size_t can be either of u32 or u64. We have a special format
>> "%pa" for printing a resource_size_t, which is the same as a phys_addr_t.
>> See Documentation/core-api/printk-formats.rst.
>>
>>   CC      drivers/edac/aspeed_edac.o
>> ../drivers/edac/aspeed_edac.c: In function 'init_csrows':
>> ../drivers/edac/aspeed_edac.c:257:21: warning: format '%x' expects 
>> argument of type 'unsigned int', but argument 4 has type 
>> 'resource_size_t' {aka 'long long unsigned int'} [-Wformat=]
>>   257 |  dev_dbg(mci->pdev, "dt: /memory node resources: first page 
>> r.start=0x%x, resource_size=0x%x, PAGE_SHIFT macro=0x%x\n",
>>   257 |  dev_dbg(mci->pdev, "dt: /memory node resources: first page 
>> r.start=0x%x, resource_size=0x%x, PAGE_SHIFT macro=0x%x\n",
>>   257 |  dev_dbg(mci->pdev, "dt: /memory node resources: first page 
>> r.start=0x%x, resource_size=0x%x, PAGE_SHIFT macro=0x%x\n",
>> ../drivers/edac/aspeed_edac.c:257:21: warning: format '%x' expects 
>> argument of type 'unsigned int', but argument 5 has type 
>> 'resource_size_t' {aka 'long long unsigned int'} [-Wformat=]
>>   257 |  dev_dbg(mci->pdev, "dt: /memory node resources: first page 
>> r.start=0x%x, resource_size=0x%x, PAGE_SHIFT macro=0x%x\n",
>>   257 |  dev_dbg(mci->pdev, "dt: /memory node resources: first page 
>> r.start=0x%x, resource_size=0x%x, PAGE_SHIFT macro=0x%x\n",
>>   257 |  dev_dbg(mci->pdev, "dt: /memory node resources: first page 
>> r.start=0x%x, resource_size=0x%x, PAGE_SHIFT macro=0x%x\n",
>>
>> Fixes: 9b7e6242ee4e ("EDAC, aspeed: Add an Aspeed AST2500 EDAC driver")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Cc: Troy Lee <troy_lee@aspeedtech.com>
>> Cc: Stefan Schaeckeler <sschaeck@cisco.com>
>> Cc: linux-edac at vger.kernel.org
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: Borislav Petkov <bp@suse.de>
>> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
>> Cc: Tony Luck <tony.luck@intel.com>
>> Cc: linux-aspeed at lists.ozlabs.org
>> ---
>> Found in linux-next but applies to mainline.
> 
>>
>>  drivers/edac/aspeed_edac.c |    8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> --- linux-next-20210503.orig/drivers/edac/aspeed_edac.c
>> +++ linux-next-20210503/drivers/edac/aspeed_edac.c
>> @@ -234,6 +234,7 @@ static int init_csrows(struct mem_ctl_in
>>  	u32 nr_pages, dram_type;
>>  	struct dimm_info *dimm;
>>  	struct device_node *np;
>> +	resource_size_t rsize;
>>  	struct resource r;
>>  	u32 reg04;
>>  	int rc;
>> @@ -254,11 +255,12 @@ static int init_csrows(struct mem_ctl_in
>>  		return rc;
>>  	}
>>  
>> -	dev_dbg(mci->pdev, "dt: /memory node resources: first page 
>> r.start=0x%x, resource_size=0x%x, PAGE_SHIFT macro=0x%x\n",
>> -		r.start, resource_size(&r), PAGE_SHIFT);
>> +	rsize = resource_size(&r);
>> +	dev_dbg(mci->pdev, "dt: /memory node resources: first page 
>> r.start=0x%pa, resource_size=0x%pa, PAGE_SHIFT macro=0x%x\n",
>> +		&r.start, &rsize, PAGE_SHIFT);
> 
> Arnd posted a fix a few days back that feels more intuitive, though 
> probably could have cleaned up the grammar:
> 
> https://lore.kernel.org/lkml/20210421135500.3518661-1-arnd at kernel.org/

Oh, that's fine. I just missed it. :(

thanks.
-- 
~Randy


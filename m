From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Thu, 17 Mar 2022 14:45:19 +0700
Subject: [PATCH v6 3/4] ipmi: ssif_bmc: Return -EFAULT if copy_from_user()
 fails
In-Reply-To: <YirzJj/BBUQTbKS3@ninjato>
References: <20220310114119.13736-1-quan@os.amperecomputing.com>
 <20220310114119.13736-4-quan@os.amperecomputing.com>
 <YirzJj/BBUQTbKS3@ninjato>
Message-ID: <db5a879e-5e2f-24f0-c0fb-4971679a45cb@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Added Dan as I have missed Dan's email address in the first place.
My apologize,
- Quan

On 11/03/2022 13:58, Wolfram Sang wrote:
> On Thu, Mar 10, 2022 at 06:41:18PM +0700, Quan Nguyen wrote:
>> From: Dan Carpenter <dan.carpenter@oracle.com>
>>
>> The copy_from_user() function returns the number of bytes remaining to
>> be copied but we should return -EFAULT here.
>>
>> Fixes: 501c25b59508 ("ipmi: ssif_bmc: Add SSIF BMC driver")
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>> Signed-off-by: Corey Minyard <cminyard@mvista.com>
>> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> 
> It is nice that you want to keep this patch seperate to give Dan
> credits, but I still think it should be merged into patch 1, so the
> initial driver is as flawless as it can be. You could give Dan still
> credits by mentioning him in the commit message IMO. Dan, would you be
> fine with this?
> 
>> v6:
>>    + New add in v6, thanks Dan for the patch     [Dan]
>>
>>   drivers/char/ipmi/ssif_bmc.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/char/ipmi/ssif_bmc.c b/drivers/char/ipmi/ssif_bmc.c
>> index 62db97773654..91ac2cae756e 100644
>> --- a/drivers/char/ipmi/ssif_bmc.c
>> +++ b/drivers/char/ipmi/ssif_bmc.c
>> @@ -87,9 +87,8 @@ static ssize_t ssif_bmc_write(struct file *file, const char __user *buf, size_t
>>   	if (count > sizeof(struct ssif_msg))
>>   		return -EINVAL;
>>   
>> -	ret = copy_from_user(&msg, buf, count);
>> -	if (ret)
>> -		return ret;
>> +	if (copy_from_user(&msg, buf, count))
>> +		return -EFAULT;
>>   
>>   	if (!msg.len || count < ssif_msg_len(&msg))
>>   		return -EINVAL;
>> -- 
>> 2.35.1
>>

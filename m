From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Thu, 8 Apr 2021 19:02:09 +0700
Subject: [PATCH v2 3/4] hwmon: smpro: Add Ampere's Altra smpro-hwmon driver
In-Reply-To: <d9ef40ea-e4ee-cea8-96df-90ffabdff53c@roeck-us.net>
References: <20210329015238.19474-1-quan@os.amperecomputing.com>
 <20210329015238.19474-4-quan@os.amperecomputing.com>
 <bac92db0-3ef6-1615-0e92-aabd54fd0580@roeck-us.net>
 <136d036c-1d10-cecd-abcb-d206a0c6fa51@os.amperecomputing.com>
 <d9ef40ea-e4ee-cea8-96df-90ffabdff53c@roeck-us.net>
Message-ID: <8267ad09-26dc-7581-567e-7286f4d7435e@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 07/04/2021 19:11, Guenter Roeck wrote:
> On 4/7/21 12:41 AM, Quan Nguyen wrote:
> [ ... ]
>>>
>>> But then why don't you just use reg_ext to store SOC_VR_HOT_THRESHOLD_REG
>>> or MEM_HOT_THRESHOLD_REG ? It is already available, after all, and with it
>>> the code could be simplified to
>>>
>>>  ??????? ret = regmap_read(hwmon->regmap, temperature[channel].reg_ext, &value);
>>>  ??????? if (ret)
>>>  ??????????? return ret;
>>>
>> Thank you for the comment.
>>
>> Will change code follow this suggestion, will include in next version
>>
>>> I don't have a datasheet, but I do wonder what is in bit 9..15. Any idea ?
>>> Main question is if there is a sign bit, as theoretic as it may be.
>>>
>> The original intention was to use this as 9-bit 2-complement value follow LM75, but the fact is that the operation temperature is 0-125 C degree, so we simply use it as-is.
>>
> 
> The operational temperature is not the question here. The question is if the
> chip _reports_ a sign. If it does, it should be handled, even if it is outside
> the operational range. The reported range is relevant here, not the operational
> range. After all, the chip won't really blow apart at -1 degrees C.
> 

I think I've got it, will handle the sign bit in next version.

-Quan

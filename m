From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Wed, 1 Jun 2022 15:23:11 +0700
Subject: [Openipmi-developer] [PATCH v7 1/3] ipmi: ssif_bmc: Add SSIF BMC
 driver
In-Reply-To: <20220504120631.GE3767252@minyard.net>
References: <20220422040803.2524940-1-quan@os.amperecomputing.com>
 <20220422040803.2524940-2-quan@os.amperecomputing.com>
 <20220423015119.GE426325@minyard.net>
 <ec7b86ec-827f-da64-8fd2-eae09f802694@os.amperecomputing.com>
 <20220504120631.GE3767252@minyard.net>
Message-ID: <ba084735-0781-7ca2-4d04-a70a4115729a@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 04/05/2022 19:06, Corey Minyard wrote:
> On Wed, May 04, 2022 at 01:45:03PM +0700, Quan Nguyen via Openipmi-developer wrote:
>>>
>>> I seem to remember mentioning this before, but there is no reason to
>>> pack the structures below.
>>>
>>
>> The packed structure is because we want to pick the len directly from user
>> space without worry about the padding byte.
>>
>> As we plan not to use the .h file in next version, I still would like to use
>> packed structure internally inside ssif_bmc.c file.
> 
> Packed doesn't matter for the userspace API.  If you look at other
> structures in the userspace API, they are not packed, either.  The
> compiler will do the right thing on both ends.
> 
>>
>>> And second, the following is a userspace API structures, so it needs to
>>> be in its own file in include/uapi/linux, along with any supporting
>>> things that users will need to use.  And your userspace code should be
>>> using that file.
>>>
>>
>> Meantime, I'd like not to use .h as I see there is no demand for sharing the
>> data structure between kernel and user space yet. But we may do it in the
>> future.
> 
> If you have a userspace API, it needs to be in include/uapi/linux.
> You may not be the only user of this code.  In fact, you probably won't
> be.  You need to have a .h with the structures in it, you don't want the
> same structure in two places if you can help it.
> 

Dear Corey,

Is it OK to push the structure definition into the 
include/uapi/linux/ipmi_bmc.h ?

Or should it need to be in separate new header file in uapi/linux ?

Thank you,
- Quan



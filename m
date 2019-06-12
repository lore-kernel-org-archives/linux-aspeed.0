From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Wed, 12 Jun 2019 09:13:20 -0700
Subject: [PATCH v3 10/10] media: aspeed: add a workaround to fix a silicon
 bug
In-Reply-To: <7486bdf6-8ab1-4e96-d5ca-b1b0f018af6b@linux.vnet.ibm.com>
References: <20190531221548.14757-1-jae.hyun.yoo@linux.intel.com>
 <20190531221548.14757-11-jae.hyun.yoo@linux.intel.com>
 <38a8ca27-9991-fe8c-4d89-abdaacd4130b@linux.intel.com>
 <490d6111-32c1-f8f4-dc3c-39314446709e@xs4all.nl>
 <7486bdf6-8ab1-4e96-d5ca-b1b0f018af6b@linux.vnet.ibm.com>
Message-ID: <cae799c1-0e10-791c-a74b-66bafd39184e@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 6/12/2019 8:03 AM, Eddie James wrote:
> 
> On 6/12/19 2:17 AM, Hans Verkuil wrote:
>> Eddie: ping!
>>
>> Regards,
>>
>> ????Hans
>>
>> On 6/6/19 2:53 AM, Jae Hyun Yoo wrote:
>>> Hi Eddie,
>>>
>>> All patches in this series were queued to linux/media tree except this
>>> one. Can you please review this patch?
>>>
>>> Thanks,
>>> Jae
>>>
>>> On 5/31/2019 3:15 PM, Jae Hyun Yoo wrote:
>>>> AST2500 silicon revision A1 and A2 have a silicon bug which causes
>>>> extremly long capturing time on specific resolutions (1680 width).
>>>> To fix the bug, this commit adjusts the capturing window register
>>>> setting to 1728 if detected width is 1680. The compression window
>>>> register setting will be kept as the original width so output
>>>> result will be the same.

Hi Hans,

Can you please fix a typo in the commit message when you queue this
patch? Thanks in advance!

s/extremly/extremely/g

> 
> 
> Sorry, missed your followup email Jae and assumed everything was merged.
> 
> 
> Looks fine to me.
> 
> Reviewed-by: Eddie James <eajames@linux.ibm.com>

Thanks for your review Eddie!

Regards,
Jae

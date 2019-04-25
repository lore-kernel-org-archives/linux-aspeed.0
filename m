From: Hans Verkuil <hverkuil@xs4all.nl>
Date: Thu, 25 Apr 2019 09:19:05 +0200
Subject: [PATCH v2 3/4] media: dt-bindings: aspeed-video: Add missing
 memory-region property
In-Reply-To: <20190424211732.GA18914@bogus>
References: <1556119020-7609-1-git-send-email-eajames@linux.ibm.com>
 <1556119020-7609-4-git-send-email-eajames@linux.ibm.com>
 <20190424211732.GA18914@bogus>
Message-ID: <6a8601d6-ad30-132c-f47a-adc3b4d39958@xs4all.nl>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 4/24/19 11:17 PM, Rob Herring wrote:
> On Wed, 24 Apr 2019 10:16:59 -0500, Eddie James wrote:
>> Missed documenting this property in the initial commit.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>> Changes since v1:
>>  - Add missing semi-colon
>>
>>  Documentation/devicetree/bindings/media/aspeed-video.txt | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
> 
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
> 
> If a tag was not added on purpose, please state why and what changed.
> 

I noticed the same when I was processing this patch. I've added back your
'Reviewed-by' tag.

So there is no need to repost, Eddie. Just remember this for the next
time :-)

Regards,

	Hans

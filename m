From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Tue, 22 Oct 2019 10:09:06 -0700
Subject: [PATCH i2c-next 1/2] dt-bindings: i2c: aspeed: add hardware
 timeout support
In-Reply-To: <20191022045655.GA975@kunai>
References: <20191021202414.17484-1-jae.hyun.yoo@linux.intel.com>
 <20191021202414.17484-2-jae.hyun.yoo@linux.intel.com>
 <0a629f7b-b829-c332-27d8-dc825205ff72@axentia.se>
 <7abf933b-cb18-10af-9c1b-163ec65ffae5@linux.intel.com>
 <20191022045655.GA975@kunai>
Message-ID: <5cd54c07-4e97-9ed9-1427-d46a7133ee53@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 10/21/2019 9:56 PM, Wolfram Sang wrote:
> 
>> Changes I submitted in this patch set is for a different purpose which
>> is very Aspeed H/W specific, and actually it's a more serious timeout
>> setting indeed. If this H/W is used in multi-master environment, it
>> could meet a H/W hang that freezes itself in slave mode and it can't
>> escape from the state. To resolve the specific case, this H/W provides
>> self-recovery feature which monitors abnormal state of SDA, SCL and its
>> H/W state machine using the timeout setting to determine the escape
>> condition.
> 
> Thanks for the summary. I just wonder on what the timeout value depends.
> Do we really need to put in DT or can we derive it e.g. from the
> compatible value in the driver?

It could be derived from the bus timeout value by computing 'divide by
x' roughly but it couldn't cover all use cases because this H/W timeout
value would depends on each environment. There are many factors that
can affect it such as bus speed, peer-master's bus driving
characteristic, average transaction period on the bus and so on thus
it may need fine adjustments through a DT setting, I think.

Thanks,

Jae

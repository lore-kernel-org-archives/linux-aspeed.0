From: Tao Ren <taoren@fb.com>
Date: Fri, 21 Jun 2019 22:21:23 +0000
Subject: [Potential Spoof] Re: [PATCH 1/2] i2c: aspeed: allow to customize
 base clock divisor
In-Reply-To: <56ff5fa8-091a-2cbc-dfa3-b912cf328695@fb.com>
References: <20190619205009.4176588-1-taoren@fb.com>
 <CAFd5g45TMtXcuqONdkpN_K+c0O+wUw8wkGzcQfV+sO8p5Krc9w@mail.gmail.com>
 <18565fcf-3dc1-b671-f826-e4417e4ad284@fb.com>
 <c610ecede7494c189a92a9a3f6d0fd16@TWMBX02.aspeed.com>
 <bdd53adb-6987-1b91-adde-298839b2c066@fb.com>
 <195bb56028d04001bbaf835cc17e032e@TWMBX02.aspeed.com>
 <56ff5fa8-091a-2cbc-dfa3-b912cf328695@fb.com>
Message-ID: <4b939e17-f364-4e63-f254-17bd531f75e6@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 6/20/19 1:13 AM, Tao Ren wrote:
> On 6/20/19 1:01 AM, Ryan Chen wrote:
>> Hello Tao,
>> 	Let me more clear. When you set (3, 15, 14) the device sometimes response nack. 
>> 	but when you set (4, 7, 7), the device always ack. Am I right? 
>> Ryan
> 
> Hello Ryan,
> 
> It's correct. We have seen the problem on 2 Facebook BMC platforms so far. Given the other ~10 Facebook BMC platforms are still running kernel 4.1 (with (4, 7, 7) settings), I'd assume more platforms will be impacted after upgrading to the latest kernel.
> 
> Thank you for spending time on this!

Just heads up Ryan and I are working with ODM vendors to collect scope output; will update back when we have new findings. Thank you all for spending time on this.


Cheers,

Tao

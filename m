From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Tue, 09 Jul 2024 20:11:59 -0000
Subject: [PATCH] fsi: add missing MODULE_DESCRIPTION() macros
In-Reply-To: <3edca7a4-361b-4381-8b13-70584a30e2b1@linux.ibm.com>
References: <20240605-md-drivers-fsi-v1-1-fefc82d81b12@quicinc.com>
 <4d1276a3-ef4a-4c84-8d09-d1613f311a28@quicinc.com>
 <3edca7a4-361b-4381-8b13-70584a30e2b1@linux.ibm.com>
Message-ID: <1f167dbf-9744-433c-aa5c-a35b66b79dde@quicinc.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 7/1/2024 8:00 AM, Eddie James wrote:
> 
> On 6/26/24 00:15, Jeff Johnson wrote:
>> On 6/5/2024 3:39 PM, Jeff Johnson wrote:
>>> make allmodconfig && make W=1 C=1 reports:
>>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-core.o
>>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-hub.o
>>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-aspeed.o
>>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-gpio.o
>>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-ast-cf.o
>>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-scom.o
>>>
>>> Add the missing invocations of the MODULE_DESCRIPTION() macro, and fix the
>>> copy/paste of the module description comment in fsi-master-ast-cf.c.
> 
> 
> Thanks!
> 
> Reviewed-by: Eddie James <eajames@linux.ibm.com>

I still don't see this in linux-next yet so following up again to see if
anything else is needed to get this merged.



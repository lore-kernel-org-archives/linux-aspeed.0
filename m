From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Fri, 2 Apr 2021 08:59:58 +0700
Subject: [PATCH v2 3/3] bindings: ipmi: Add binding for Aspeed SSIF BMC
 driver
In-Reply-To: <20210401170933.GA622142@robh.at.kernel.org>
References: <20210330141029.20412-1-quan@os.amperecomputing.com>
 <20210330141029.20412-4-quan@os.amperecomputing.com>
 <20210401170933.GA622142@robh.at.kernel.org>
Message-ID: <62acc395-de5b-fd5c-c74f-d7d713b43377@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 02/04/2021 00:09, Rob Herring wrote:
> On Tue, Mar 30, 2021 at 09:10:29PM +0700, Quan Nguyen wrote:
>> Add device tree binding document for the Aspeed SSIF BMC driver.
>>
>> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
>> ---
>>   .../bindings/ipmi/aspeed-ssif-bmc.txt          | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/ipmi/aspeed-ssif-bmc.txt
> 
> Same comment as you ignored on v1.
> 

Dear Rob,
I really did not mean to do that.

What happen is that there was a compilation error complaint by kernel 
robot test on my v1. So I tried to send my v2 to fix that issue asap. 
Unfortunately, your reply on my v1 arrived just right after I hit "git 
send-email" to send out my v2.

For this comment, I'll switch to use yaml file in next version.

- Quan

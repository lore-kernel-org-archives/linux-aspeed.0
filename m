From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Fri, 16 Jul 2021 09:45:32 +0700
Subject: [PATCH v5 3/3] bindings: ipmi: Add binding for SSIF BMC driver
In-Reply-To: <20210715174339.GA1309142@robh.at.kernel.org>
References: <20210714033833.11640-1-quan@os.amperecomputing.com>
 <20210714033833.11640-4-quan@os.amperecomputing.com>
 <20210715174339.GA1309142@robh.at.kernel.org>
Message-ID: <c2deac6c-54e0-c73b-161c-163acc975211@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 16/07/2021 00:43, Rob Herring wrote:
> On Wed, 14 Jul 2021 10:38:33 +0700, Quan Nguyen wrote:
>> Add device tree binding document for the SSIF BMC driver.
>>
>> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
>> ---
>> v5:
>>    + None
>>
>> v4:
>>    + Fix warning with dt_binding_check [Rob]
>>    + Change aspeed-ssif-bmc.yaml to ssif-bmc.yaml [Quan]
>>
>> v3:
>>    + Switched to use DT schema format [Rob]
>>
>> v2:
>>    + None
>>
>>   .../devicetree/bindings/ipmi/ssif-bmc.yaml    | 38 +++++++++++++++++++
>>   1 file changed, 38 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/ipmi/ssif-bmc.yaml
>>
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 

Thanks Rob.

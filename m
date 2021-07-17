From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Sat, 17 Jul 2021 19:51:52 +0700
Subject: [PATCH v5 1/4] dt-bindings: mfd: Add bindings for Ampere Altra
 SMPro MFD driver
In-Reply-To: <20210716173443.GA3643583@robh.at.kernel.org>
References: <20210713060031.31568-1-quan@os.amperecomputing.com>
 <20210713060031.31568-2-quan@os.amperecomputing.com>
 <20210716173443.GA3643583@robh.at.kernel.org>
Message-ID: <ece6e0ec-4566-0371-be57-89a69d425683@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 17/07/2021 00:34, Rob Herring wrote:
> On Tue, 13 Jul 2021 13:00:28 +0700, Quan Nguyen wrote:
>> Adds device tree bindings for SMPro MFD driver found on the Mt.Jade
>> hardware reference platform with Ampere's Altra Processor family.
>>
>> The SMpro co-processor on Ampere Altra processor family is to monitor
>> and report various data included hwmon-related info, RAS errors, and
>> other miscellaneous information.
>>
>> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
>> ---
>> Changes in v5:
>>    + Dropped ../bindings/hwmon/ampere,ac01-hwmon.yaml file [Quan]
>>    + Removed patternProperties section and child DT nodes in example
>>    section [Quan]
>>    + Revised commit message [Quan]
>>
>> Changes in v4:
>>    + Revised the commit message to clarify how the specific info will
>>      be handled commented by Rob.
>>
>> Changes in v3:
>>    + Supported list of compatible string [Rob]
>>    + Introduced reg property in DT to specify reg offset [Rob]
>>    + Updated description and other minor changes in yaml file [Rob]
>>
>> Changes in v2:
>>    + Changed "ampere,ac01-smpro" to "ampere,smpro" [Quan]
>>
>>   .../devicetree/bindings/mfd/ampere,smpro.yaml | 52 +++++++++++++++++++
>>   1 file changed, 52 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mfd/ampere,smpro.yaml
>>
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
>

Thanks Rob for the review.
- Quan



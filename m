From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Thu, 21 Jul 2022 09:46:42 +0700
Subject: [PATCH v2 1/2] dt-bindings: arm: aspeed: document Ampere
 Mt.Mitchell BMC compatibles
In-Reply-To: <0a5cbaaa-565a-7215-5e31-12c52f4bbcbd@linaro.org>
References: <20220720085230.3801945-1-quan@os.amperecomputing.com>
 <20220720085230.3801945-2-quan@os.amperecomputing.com>
 <0a5cbaaa-565a-7215-5e31-12c52f4bbcbd@linaro.org>
Message-ID: <4516d7a6-f493-aa51-2700-bbab8ea8533a@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 20/07/2022 17:34, Krzysztof Kozlowski wrote:
> On 20/07/2022 10:52, Quan Nguyen wrote:
>> Document Ampere Mt.Mitchell BMC board compatible.
>>
>> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> 
> Thank you for your patch. There is something to discuss/improve.
> 
>> ---
>> v2:
>>    + Introduce in v2 to add Ampere Mt. Mitchell BMC compatible [Krzysztof]
>>
>>   Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
>> index d61408194998..b8146d5c4431 100644
>> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
>> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
>> @@ -71,6 +71,7 @@ properties:
>>             - enum:
>>                 - aspeed,ast2600-evb
>>                 - aspeed,ast2600-evb-a1
>> +              - ampere,mtmitchell-bmc
> 
> Put the entry ordered alphabetically.
> 

Thanks Krzysztof for the review.

Will change to :
              - enum:
  +              - ampere,mtmitchell-bmc
                 - aspeed,ast2600-evb
                 - aspeed,ast2600-evb-a1

But, should we correct the below as well? ie: to move 
"ampere,mtjade-bmc" to before "aspeed,ast2500-evb" ?

- description: AST2500 based boards
         items:
           - enum:
               - aspeed,ast2500-evb
               - amd,ethanolx-bmc
               - ampere,mtjade-bmc
               - asrock,e3c246d4i-bmc

Thanks,
- Quan

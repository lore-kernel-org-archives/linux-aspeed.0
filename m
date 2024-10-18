From: Chanh Nguyen <chanh@amperemail.onmicrosoft.com>
Date: Fri, 18 Oct 2024 17:08:29 +0700
Subject: [PATCH] ARM: dts: aspeed: Add device tree for Ampere's Mt.
 Jefferson BMC
In-Reply-To: <d514fd066353c529052e59c564d1d15f91b6a8b5.camel@codeconstruct.com.au>
References: <20241014105031.1963079-1-chanh@os.amperecomputing.com>
 <d514fd066353c529052e59c564d1d15f91b6a8b5.camel@codeconstruct.com.au>
Message-ID: <21065884-97c7-4815-9347-f4f03dff8c43@amperemail.onmicrosoft.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 18/10/2024 11:34, Andrew Jeffery wrote:
> Hi Chanh,
> 
> On Mon, 2024-10-14 at 10:50 +0000, Chanh Nguyen wrote:
>>
>> +&mac3 {
>> +	status = "okay";
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_rmii4_default>;
>> +	clock-names = "MACCLK", "RCLK";
> 
> Should this be overriding `clocks` also? There's only one clock
> specified in the dtsi.
> 

Thank Andrew,
I think it is redundant config. I don't need to override the `clock` and 
`clock-names` here. The mac3 will use the clock specified in the dtsi.
I'll remove `clock-names` in the patch v2

Summary, I need to update as the below list.
1. Add Mt. Jefferson board compatible binding as Krzysztof pointed.
2. Remove the PSU node with "pmbus" compatible.
3. Remove `clock-names' property in mac3 node

Regards,
Chanh

> Andrew
> 
>> +	use-ncsi;
>> +};


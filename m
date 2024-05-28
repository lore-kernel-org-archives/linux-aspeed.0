From: Eddie James <eajames@linux.ibm.com>
Date: Tue, 28 May 2024 09:50:51 -0500
Subject: [PATCH v6 14/20] ARM: dts: aspeed: Add IBM P11 Blueridge BMC
 system
In-Reply-To: <dca4ac91-c18b-4271-a3f9-fbf3b5a3c43d@linux.ibm.com>
References: <20240522192524.3286237-1-eajames@linux.ibm.com>
 <20240522192524.3286237-15-eajames@linux.ibm.com>
 <dca4ac91-c18b-4271-a3f9-fbf3b5a3c43d@linux.ibm.com>
Message-ID: <45724dae-ebe6-48f9-8cb7-d6e27d5fdad9@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 5/24/24 17:47, Ninad Palsule wrote:
>> +		led at 6 {
>> +			reg = <6>;
>> +			default-state = "keep";
>> +			label = "cpu-vrm1";
>> +			retain-state-shutdown;
>> +			type = <PCA955X_TYPE_LED>;
>> +		};
>> +
> Is there a specific reason for skipping led at 7? Its not connected?


Yes, again not connected.


>> +		led at 8 {
>> +			reg = <8>;
>> +			default-state = "keep";
>> +			label = "lcd-russel";
>> +			retain-state-shutdown;
>> +			type = <PCA955X_TYPE_LED>;
>> +		};
>> +	};
>> +
>
> Reviewed-by: Ninad Palsule <ninad@linux.ibm.com>
>

Thanks,

Eddie


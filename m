From: Eddie James <eajames@linux.ibm.com>
Date: Tue, 28 May 2024 09:47:15 -0500
Subject: [PATCH v6 16/20] ARM: dts: aspeed: Add IBM P11 Fuji BMC system
In-Reply-To: <3ac517f0-0394-4310-8840-d806de5ec082@linux.ibm.com>
References: <20240522192524.3286237-1-eajames@linux.ibm.com>
 <20240522192524.3286237-17-eajames@linux.ibm.com>
 <3ac517f0-0394-4310-8840-d806de5ec082@linux.ibm.com>
Message-ID: <1966e65d-4cde-4a91-99b3-126d1b5d3d84@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 5/28/24 09:08, Ninad Palsule wrote:
>
> Hi Eddie,
>
>> +
>> +		led at 6 {
>> +			reg = <6>;
>> +			default-state = "keep";
>> +			label = "opencapi-connector5";
>> +			retain-state-shutdown;
>> +			type = <PCA955X_TYPE_LED>;
>> +		};
> is led at 7 not connected?


Correct.


>> +
>> +		led at 8 {
>> +			reg = <8>;
>> +			default-state = "keep";
>> +			label = "vrm4";
>> +			retain-state-shutdown;
>> +			type = <PCA955X_TYPE_LED>;
>> +		};
>> +
>> +		led at 9 {
>> +			reg = <9>;
>> +			default-state = "keep";
>> +			label = "vrm5";
>> +			retain-state-shutdown;
>> +			type = <PCA955X_TYPE_LED>;
>> +		};
>> +
>> +		led at 10 {
>> +			reg = <10>;
>> +			default-state = "keep";
>> +			label = "vrm6";
>> +			retain-state-shutdown;
>> +			type = <PCA955X_TYPE_LED>;
>> +		};
>> +
>> +		led at 11 {
>> +			reg = <11>;
>> +			default-state = "keep";
>> +			label = "vrm7";
>> +			retain-state-shutdown;
>> +			type = <PCA955X_TYPE_LED>;
>> +		};
>> +
>> +		led at 12 {
>> +			reg = <12>;
>> +			default-state = "keep";
>> +			label = "vrm12";
>> +			retain-state-shutdown;
>> +			type = <PCA955X_TYPE_LED>;
>> +		};
> curious about label jump from vrm7 to vrm12.


vrm0-3 and 8-11 are on the previous pca chip. I believe this is correct 
based on the wiring in the spec, though the numberings are really just 
convention established by the guy who managed the LEDs on the system.


>> +			cfam4_i2c10: i2c-bus at a {
>> +				reg = <10>;	/* OP3A */
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> It will be more readable to have "reg" value in hex too. I have seen similar stuff in this FSI nodes. It will be consistent with other places.
>> +
>
> Reviewed-by: Ninad Palsule <ninad@linux.ibm.com>
>

Sure, thanks!

Eddie



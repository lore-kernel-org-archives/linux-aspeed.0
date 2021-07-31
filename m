From: Jonathan Cameron <jic23@kernel.org>
Date: Sat, 31 Jul 2021 18:24:29 +0100
Subject: [v2 2/8] dt-bindings: iio: adc: Binding ast2600 adc.
In-Reply-To: <8D93D26B-AE57-4E38-A1AD-FA62894F2947@aspeedtech.com>
References: <20210723081621.29477-1-billy_tsai@aspeedtech.com>
 <20210723081621.29477-3-billy_tsai@aspeedtech.com>
 <20210723155141.000039ee@Huawei.com>
 <8D93D26B-AE57-4E38-A1AD-FA62894F2947@aspeedtech.com>
Message-ID: <20210731182334.2be68876@jic23-huawei>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 26 Jul 2021 07:21:29 +0000
Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> Hi Jonathan,
> 
> Thanks for your review. I will fix them.
> About the vref I reply inline.
> 
> On 2021/7/23, 10:52 PM, "Jonathan Cameron" <Jonathan.Cameron@Huawei.com> wrote:
> 
>     On Fri, 23 Jul 2021 16:16:15 +0800
>     Billy Tsai <billy_tsai@aspeedtech.com> wrote:
> 
>     >   > +  ? Internal or External reference voltage.
>     >   > +  ? Support 2 Internal reference voltage 1.2v or 2.5v.
>     >   > +  ? Integrate dividing circuit for battery sensing.
>     >   >  
>     >   >  properties:
>     >   >    compatible:
>     >   >      enum:
>     >   >        - aspeed,ast2400-adc
>     >   >        - aspeed,ast2500-adc
>     >   > +      - aspeed,ast2600-adc
>     >   >  
>     >   >    reg:
>     >   >      maxItems: 1
>     >   > @@ -33,6 +45,18 @@ properties:
>     >   >    "#io-channel-cells":
>     >   >      const: 1
>     >   >  
>     >   > +  vref:
>     >   > +    minItems: 900
>     >   > +    maxItems: 2700
>     >   > +    default: 2500
>     >   > +    description:
>     >   > +      ADC Reference voltage in millivolts.  
> 
>     >   I'm not clear from this description.  Is this describing an externally
>     >   connected voltage reference?  If so it needs to be done as a regulator.
>     >   If it's a classic high precision reference, the dts can just use
>     >   a fixed regulator.  
> 
> In the ast2600, the ADC supports two internal reference voltages of 1.2v or 2.5v,
> as well as external voltages. When the user selects a voltage of 1.2v or 2.5v, my
> driver will first select to use the internal voltage. 

Understood.

> As you mention at patch #4, you suggest to use two property to handle this feature.
> vref: indicate the regulator handler. Like other dt-bindings used.

vref-supply would be the binding but otherwise yes.

> aspeed,int_vref_mv: indicate the chosen of 1.2v or 2.5v
> and use "model_data->vref_fixed" to exclude ast2400 and ast2500
> Is it right?
Ideally you would check in the driver and also use something here
to allow device trees to be checked automatically.  Something like

allOf:
 - if:
     not:
       properties:
         compatible:
           contains: const: aspeed,ast2600-adc
             then:
               int_vref_mv: false

that will ensure the property is only used for the ast2600.

Note the above is from memory, so may well have incorrect syntax.
I've never found yaml intuitive!

Thanks,


Jonathan

         
> 
> Thanks
> 
>     >   > +
>     >   > +  battery-sensing:
>     >   > +    type: boolean
>     >   > +    description:
>     >   > +      Inform the driver that last channel will be used to sensor battery.  
> 
>     >   This isn't (I think?) a standard dt binding, so it needs a manufacturer
>     >   prefix.  
> 
>     >   aspeed,battery-sensing  
> 
> Best Regards,
> Billy Tsai
> 
> 


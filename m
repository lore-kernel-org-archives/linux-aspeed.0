From: James Feist <james.feist@linux.intel.com>
Date: Mon, 17 Dec 2018 11:50:00 -0800
Subject: [Potential Spoof] Re: [PATCH 1/4] ARM: dts: aspeed: Add sensors
 devices for Facebook
In-Reply-To: <E3F1FFD7-1C5A-43DE-BCA6-5B50EEEF577F@fb.com>
References: <E3F1FFD7-1C5A-43DE-BCA6-5B50EEEF577F@fb.com>
Message-ID: <024aee07-0444-cdaf-d274-b07244aec7b2@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 12/17/18 11:39 AM, Vijay Khemka wrote:
> 
> 
> ?On 12/14/18, 12:42 PM, "Linux-aspeed on behalf of Vijay Khemka" <linux-aspeed-bounces+vijaykhemka=fb.com at lists.ozlabs.org on behalf of vijaykhemka@fb.com> wrote:
> 
>      
>      
>      On 12/14/18, 11:22 AM, "openbmc on behalf of Jae Hyun Yoo" <openbmc-bounces+vijaykhemka=fb.com at lists.ozlabs.org on behalf of jae.hyun.yoo@linux.intel.com> wrote:
>      
>          Hi Vijay,
>          
>          On 12/14/2018 10:11 AM, Vijay Khemka wrote:
>          > On 12/13/18, 2:56 PM, "Joel Stanley" <joel@jms.id.au> wrote:
>          
>          <snip>
>          
>          >      > +               oemname0 = "MB_P3V3";
>          >      > +               oemname1 = "MB_P5V";
>          >      > +               oemname2 = "MB_P12V";
>          >      > +               oemname3 = "MB_P1V05";
>          >      > +               oemname4 = "MB_PVNN_PCH_STBY";
>          >      > +               oemname5 = "MB_P3V3_STBY";
>          >      > +               oemname6 = "MB_P5V_STBY";
>          >
>          >      "oemname" isn't part of the upstream bindings. Is this something you
>          >      have patches for?
>          > This is a workaround field used by dbus-sensors application to avoid overlay for dynamic detection of devices based on json file definition.
>          >
>          > Can you please also review other 3 patches in this series.
>          >
>          >
>          
>          These oemname settings should not be added into here. You can add these
>          information into configuration of entity manager which uses overlay
>          templates for dbus-sensors. Also, as Joel said, "oemname" isn't part of
>          the upstream bindings.
>      
>      Overlay templates from entity manager is not working for fan and adc sensors that's why it is a workaround suggested by James Feist (Author of dbus-sensors).
> 
> @james.feist at linux.intel.com,
> Please comment on above patch, please advise if I need to fix this.

Yes, this is a workaround. It should not be added to your device tree. 
This has already been fixed for the fans, someone just needs to spend a 
little bit of time to fix the ADCs then it won't be needed.

Thanks,

James


>          
>          Cheers,
>          Jae
>          
>      
>      
> 

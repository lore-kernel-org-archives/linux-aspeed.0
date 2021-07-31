From: Jonathan Cameron <jic23@kernel.org>
Date: Sat, 31 Jul 2021 18:27:14 +0100
Subject: [v2 1/8] dt-bindings: iio: adc: rename the aspeed adc yaml
In-Reply-To: <YQMQJ15KpM0eeLIb@robh.at.kernel.org>
References: <20210723081621.29477-1-billy_tsai@aspeedtech.com>
 <20210723081621.29477-2-billy_tsai@aspeedtech.com>
 <20210723154456.00006744@Huawei.com>
 <E650AFD8-FFD1-4D87-87B0-42D20D9C3BB4@aspeedtech.com>
 <YQMQJ15KpM0eeLIb@robh.at.kernel.org>
Message-ID: <20210731182714.7197bdcc@jic23-huawei>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 29 Jul 2021 14:31:35 -0600
Rob Herring <robh@kernel.org> wrote:

> On Mon, Jul 26, 2021 at 06:53:07AM +0000, Billy Tsai wrote:
> > Hi Jonathan,
> > 
> > On 2021/7/23, 10:45 PM, "Jonathan Cameron" <Jonathan.Cameron@Huawei.com> wrote:
> > 
> >     On Fri, 23 Jul 2021 16:16:14 +0800
> >     Billy Tsai <billy_tsai@aspeedtech.com> wrote:
> >   
> >     >   > The aspeed,ast2400-adc.yaml not only descriptor the bindings of ast2400.
> >     >   > Rename it to aspeed,adc.yaml for all of the aspeed adc bindings.
> >     >   > 
> >     >   > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>  
> >   
> >     >   We try to avoid 'wild' card type namings most of the time and instead
> >     >   name after a particular part number.  I say try because clearly
> >     >   we let a few in over the years :(  
> >   
> >     >   It is very hard to know if this binding will apply to 'all' future
> >     >   aspeed ADCs.  
> >   
> >     >   As such I'm not sure this particular rename makes sense.  
> > 
> > If I want to extend the yaml file to compatible more versions of the aspeed adc.
> > Would you suggest to add new files call aspeed,ast2600-adc.yaml or just append it
> > to the aspeed,ast2400-adc.yaml?  
> 
> If 2600 is not backwards compatible with 2400, then probably a new 
> schema file. Given you are adding new properties (which only apply to 
> 2600?), then most likely a new schema file. Depends at which point there 
> are too many conditional (if/then/else) schemas.

Agreed.  It's a judgement call you need to make on when it is worth the new file.
Note that doesn't have anything to do with splitting the driver.  We have mulitple
binding files for single drivers and for that matter multiple drivers for single binding
files.

If it is 'compatible' enough to not make the file to complex, then add to the existing
ast2400 file without renaming.

Jonathan

> 
> Rob


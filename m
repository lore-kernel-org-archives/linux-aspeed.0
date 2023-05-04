From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
Date: Thu, 4 May 2023 09:09:14 +0200
Subject: [Linux-stm32] [RFC PATCH 0/1] Categorize ARM dts directory
In-Reply-To: <99b49e6b-e963-415a-a2c9-72505087833c@app.fastmail.com>
References: <20220328000915.15041-1-ansuelsmth@gmail.com>
 <85eb14ec-f465-7447-ad77-a3dabc666f47@kernel.org>
 <YkKRYnN84D9VZhGj@Ansuel-xps.localdomain>
 <CAL_Jsq+RQQ-ADMxLPUFwk6S6kGmb6oNDy4k52fnU0EtbUvqmSA@mail.gmail.com>
 <CAMuHMdWNTE48MFy6fqxAsfMWz9b6E7dVNXtXtESP95sxk2PGwA@mail.gmail.com>
 <CAL_JsqJthKTm8bhRF2B=ae1tvtPeYYXx_Tm76qQtSwLtH5C6VA@mail.gmail.com>
 <720a2829-b6b5-411c-ac69-9a53e881f48d@app.fastmail.com>
 <CAL_JsqKCtmkwzKa01gyG65fH8ye6R3KhR41PJbJhOJ4X9j=znA@mail.gmail.com>
 <99b49e6b-e963-415a-a2c9-72505087833c@app.fastmail.com>
Message-ID: <95076d3b-5667-8cb3-c09a-e0b7dc2b03c3@foss.st.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 5/3/23 13:02, Arnd Bergmann wrote:
> On Tue, May 2, 2023, at 21:40, Rob Herring wrote:
>> On Tue, May 2, 2023 at 3:15?AM Arnd Bergmann <arnd@arndb.de> wrote:
> 

...

> 
>>      'stm' : 'stm32',
>>      'sti' : 'sti',
>>      'st-pin' : 'sti',
>>      'ste' : 'st-ericsson',
>>      'spear' : 'spear',
> 
> I would put all five of these into 'st'. The ux500 was developed
> in st-ericsson, but last sold by st, and the other ones are all
> original st products.

Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>

thanks
Alex

> 
>        Arnd
> _______________________________________________
> Linux-stm32 mailing list
> Linux-stm32 at st-md-mailman.stormreply.com
> https://st-md-mailman.stormreply.com/mailman/listinfo/linux-stm32


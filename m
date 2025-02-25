Return-Path: <linux-aspeed+bounces-833-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42201C021BB
	for <linux-aspeed@archiver.kernel.org>; Tue, 25 Feb 2025 23:01:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z2Y4V1dpQz2ywR;
	Wed, 26 Feb 2025 10:01:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::12c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740458084;
	cv=none; b=WagafZJqG1mPiJr+c5QdNDzcfeWZy72Wz2yyi6I7+C56bsWOE0dHy5zFNrDTjFDX0rYnQjQ4b+LDVUXijgY07ExcRrWk2us/3GRWn0Q09o7oHW58dcx4Im4ZsnT0MpjN9QvAIR4Xe371ZQJYsqLqJxMr3yofAfA4dea9znQJxntjNxXMoSPx5PDmYtmownSQOEZCU+n0Gz8VsWGd2PPAiBDkQnWVNS/o3b6nmmsEmrRK/nxpHh6y9Ahe/gHtRmkKe1fOqZjT5ow25TclXw3To5w1GD1JADPNKZCLdVkM6uqx9Ui7qoLjUwy65hYBQPOVG3qAxBQDiKq0sDO5ecV4Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740458084; c=relaxed/relaxed;
	bh=XkUG0GwBbaraAGYEOMab08l1MxTvBaTLFY/Sl+KE8CQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KFOZlY6w/rLr9TAGY6GGMGpywM8WyGeJ8Aw5HjshPNdgY7OOyGxXrlhWwbSijKJLTa4Tn06IYIgVlwWdaosr79pl6zREbfVcldsuyhmau0qt0IH+wuYeAjbZezRYgMcZyc6wUWjlZS+vxVYoeaVCdWp7FzrPJxks76zqYnXVhi16GIh90UbHeIe0ZJhbjJMIzvpesff452SwixjiKwpV5w9eZklgwhDl9hrZiURZcy6pNfRxAqdhFv43tqZmiAPY1etp9SHVdnFl9z1PuI9ZouylLrR+KmBqeh+ZO+C5koGbg65nM8uz7REoClmYlOzmtLdSNO3Z5nZqx3K+jS0BgA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=xLpWTbA+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::12c; helo=mail-il1-x12c.google.com; envelope-from=elbadrym@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=xLpWTbA+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::12c; helo=mail-il1-x12c.google.com; envelope-from=elbadrym@google.com; receiver=lists.ozlabs.org)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z24Wk1vL1z2yF4
	for <linux-aspeed@lists.ozlabs.org>; Tue, 25 Feb 2025 15:34:42 +1100 (AEDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-3d19702f977so66045ab.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 24 Feb 2025 20:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740458079; x=1741062879; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XkUG0GwBbaraAGYEOMab08l1MxTvBaTLFY/Sl+KE8CQ=;
        b=xLpWTbA+J/c5gxo7bo2kqrHjECOfPXdHVHtgIC28SUs3O21fh10qs1tkEDHv3h07ye
         wdZ0ifobXD/1QX6Enxo3bg1RnOom0kBeQbzsPfhW7bME0BWDnguGVQSGknYruYgoOEA4
         /6N4NN747RV0YAxCILMljmKh+2OcAB0r62ecNVMapp1e3v14chzC880zM7bNlFJcxACU
         GPwQkFDTbP63gQ9Roh0rnlzH4EY2+19VcvLSdF+UoCKPC8zK6pHdiw/afnfKT9SCbZVP
         qottFsXE72IaPMmwe1sO4dv2zcMOXT/0rjawr7pbFCH2HaO58jPVwEwsD0o/SvwHMCs5
         C7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740458079; x=1741062879;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XkUG0GwBbaraAGYEOMab08l1MxTvBaTLFY/Sl+KE8CQ=;
        b=M7bh/eTy0Nrsi39qyUqOezIJ1AS3GxlvNsQ/Hk2tNtVA9AHa5++QepkiM42yNgzuEP
         92jIMv0yilr/d9TNlTE24pdzzLfOXhbUBY2+4CCwWPzoc/9Z8jStgSgFeje5S0BQVsK4
         mnaZb9/MP1YLwOpM/FXJiV3bbiFTsGSs1Ig/krJugRt29b8MhonVv/UbgZaVzI0bgoPo
         UaFnxHgm54VJHZxJbVXgIlr1oDeXa67mORfOPAxi4cW4uVcu6E8ifHMGy5DBtWFjqJ7c
         dfXy5gDKpwtmeMHX0zt9Vw19nyFRs6jdlX4Q9V8FiVlTGVLXYdS+KdUDIDyBO9KTFDdU
         oJBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIyTVlYVLh8dRyI4iNOqrShWgxe1AUAyeaA5eJHeVVUWKAVFGyBQoEsMx/vNs4pIO7lnwRHnAcNCPehAM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx0pC/P7pDzndEQJKfgZlFLlpknuBnouxnWq1y1TSfbi212ffiy
	X5A7M9DJOnGFkg81trIecNC7ZQIG25Mqu6AN6ihAcNxpuIcpjWWaeAxJmMke9mfj9qm/JbPYFXk
	yaqSKiSPeFyvG5iVC/WdQWtke4/v2xSPguKtP
X-Gm-Gg: ASbGncsBX9YXrKZGVnWpa1XiSpv7jdJQyXJdo/YVVOOHzdi3BUZ2X7Rw7BoyZoouV8a
	QYhFGXxSY0WvFoUA9pOngXVV9Vl3XxrTGLYxrf9BlPILYdsX/TAg3i8ZWPqVTaONGJR6O5ZRVWT
	rzFvBMgg==
X-Google-Smtp-Source: AGHT+IF49UOdhW7AncDR6zlzXgWIiZgZ82fGO/cuM4IxirlakdLxFhgx13Nw/fEGzsxv5SZjY6jn6ELtP239ruquB+4=
X-Received: by 2002:a05:6e02:1a0c:b0:3d2:ae8a:8a47 with SMTP id
 e9e14a558f8ab-3d30cee04a1mr2633655ab.29.1740458078902; Mon, 24 Feb 2025
 20:34:38 -0800 (PST)
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
References: <20250217114831.3225970-1-kevin_chen@aspeedtech.com>
 <20250217114831.3225970-4-kevin_chen@aspeedtech.com> <e43b5f8f-37e4-4468-b3ca-5059a5e6f3c3@kernel.org>
 <6fd7cd57261ddf9831f57dc4c637b24e9f8982d9.camel@codeconstruct.com.au>
 <PSAPR06MB4949C65DF5C034BD6B40C9B589FA2@PSAPR06MB4949.apcprd06.prod.outlook.com>
 <d4945482509cad0bf3e8cd93c1fb21bac2e0c7f2.camel@codeconstruct.com.au>
 <TY0PR06MB4960EA7255DF0BDF235F0D9689C52@TY0PR06MB4960.apcprd06.prod.outlook.com>
 <ba2757fd02b3e7c8f9c862c76f2cfcd2b6bfb41b.camel@codeconstruct.com.au>
 <PSAPR06MB494947E21AB39369ADFA8C9489C72@PSAPR06MB4949.apcprd06.prod.outlook.com>
 <f7369d6205e05c7aac3f3de7cbd08c3b08960d75.camel@codeconstruct.com.au>
In-Reply-To: <f7369d6205e05c7aac3f3de7cbd08c3b08960d75.camel@codeconstruct.com.au>
From: Mo Elbadry <elbadrym@google.com>
Date: Mon, 24 Feb 2025 20:34:28 -0800
X-Gm-Features: AQ5f1JqSHGfS2SMxhD4cUpRq7HcZ5M03mBDp9wnAJ9v5zfAVqgRyzEobOcV18AM
Message-ID: <CAOO6b=udHyXx3QXyUE=siuuJopanUxzbFeBujtqWRy=j2ut4fw@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] soc: aspeed: lpc-pcc: Add PCC controller support
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Kevin Chen <kevin_chen@aspeedtech.com>, "joel@jms.id.au" <joel@jms.id.au>, 
	Z-ChiaWei Wang <chiawei_wang@aspeedtech.com>, 
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tomer.maimon" <tomer.maimon@nuvoton.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, "lee@kernel.org" <lee@kernel.org>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	Jenmin Yuan <jenmin_yuan@aspeedtech.com>, BMC-SW <BMC-SW@aspeedtech.com>
Content-Type: multipart/alternative; boundary="0000000000008a8759062eeff9f2"

--0000000000008a8759062eeff9f2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

I agree that a small layer of abstraction is needed to provide common
chardev semantics to userspace. I think that effort can come where both
Nuvoton and Aspeed unify their design and agree on a common abstraction
layer.

I think such efforts may take some time for both to unify, is it possible
to get this upstreamed (after addressing all other comments) while both
parties work on an agreed unified abstraction layer?

Thank you,
Mo

On Mon, Feb 24, 2025 at 8:27=E2=80=AFPM Andrew Jeffery <andrew@codeconstruc=
t.com.au>
wrote:

> On Fri, 2025-02-21 at 00:51 +0000, Kevin Chen wrote:
> > > On Wed, 2025-02-19 at 11:59 +0000, Kevin Chen wrote:
> > > > > On Tue, 2025-02-18 at 11:11 +0000, Kevin Chen wrote:
> > > > > > > On Mon, 2025-02-17 at 13:00 +0100, Krzysztof Kozlowski wrote:
> > > > > > > > On 17/02/2025 12:48, Kevin Chen wrote:
> > > > > > > > > +
> > > > > > > > > +       pcc->mdev.parent =3D dev;
> > > > > > > > > +       pcc->mdev.minor =3D MISC_DYNAMIC_MINOR;
> > > > > > > > > +       pcc->mdev.name =3D devm_kasprintf(dev, GFP_KERNEL=
,
> > > > > > > > > "%s%d",
> > > > > > > > > DEVICE_NAME,
> > > > > > > > >
> > > > > > >
> > > > >
> > > +                                       pcc->mdev_id);
> > > > > > > > > +       pcc->mdev.fops =3D &pcc_fops;
> > > > > > > > > +       rc =3D misc_register(&pcc->mdev);
> > > > > > > > > +       if (rc) {
> > > > > > > > > +               dev_err(dev, "Couldn't register misc
> > > > > > > > > device\n");
> > > > > > > > > +               goto err_free_kfifo;
> > > > > > > > > +       }
> > > > > > > >
> > > > > > > > You cannot expose user-space interfaces from SoC drivers. U=
se
> > > > > > > > appropriate subsystem for this with proper ABI documentatio=
n.
> > > > > > > >
> > > > > > > > See:
> > > > > > > >
> https://lore.kernel.org/all/bc5118f2-8982-46ff-bc75-d0c71475e9
> > > > > > > > 09@a
> > > > > > > > pp.f
> > > > > > > > astmail.com/
> > > > > > > > and more discussions on LKML
> > > > > > >
> > > > > > > Further, drivers/misc/aspeed-lpc-snoop.c already exists:
> > > > > > >
> > > > > > >
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g
> > > > > > > it/c
> > > > > > > ommit/?id=3D
> > > > > > > 9f4f9ae81d0affc182f54dd00285ddb90e0b3ae1
> > > > > > >
> > > > > > > Kevin: Did you consider reworking it?
> > > > > > Andrew: No, I do not rework it but add the post code capture
> > > > > > driver using the SNOOP registers. As a result, I add some code =
in
> > > > > > aspeed_a2600_15 to check the SNOOP enable bit. PCC driver probe
> > > > > > abort if snoop is enabled.
> > > > >
> > > > > Hmm, I think OpenBMC's history regarding POST code support caused
> > > > > some confusion on my part. For whatever reason, the snoop device
> was
> > > > > used as a source of POST codes despite the existence of the
> > > > > dedicated POST code hardware since at least the AST2400, but...
> > > > What I know about the dedicated POST code hardware in ASPEED should
> be
> > > > the same one in LPC module.
> > > >
> > > > >
> > > > > > PCC is used for port I/O byte snooping over eSPI.
> > > > >
> > > > > ... it seems that they're largely interchangeable, just with
> > > > > different hardware features (PCC has DMA)? My impression is that
> the
> > > > > snoop device could also be used over eSPI?
> > > > Yes, PCC has DMA to capture the POST code.
> > > > And snoop device also can be used over eSPI.
> > > >
> > > > These two devices of PCC and snoop use the same port I/O of 80h and
> > > > 81h.
> > > > But, in current usage of PCC, it can support a continuous, 4-bytes
> > > > maximum region from port I/O 80h to 83h.
> > > > What I know about PCC or snoop usage, depends on INTEL platform or
> AMD
> > > > platform.
> > > >
> > > > For ASPEED, we want to upstream the PCC driver for the PCC usage.
> > >
> > > Yeah, that's fine, but I think some work needs to be done to provide
> coherence
> > > in the devicetree binding and userspace APIs across both the ASPEED
> snoop
> > > and PCC bits, as well as the Nuvoton BPC. Bespoke designs create pain=
.
> >
> https://lore.kernel.org/linux-kernel//7661de74-f68c-6617-6a4e-3b0eb76a2a2=
e@linaro.org/T/
> > Andrew, I find the "NPCM BPC driver" to get the link. Are these patches
> match what you mentioned?
>
> That looks about right.
>
> Note Rob's response there about disparate bindings:
>
>
> https://lore.kernel.org/linux-kernel//20221130193014.GA2645083-robh@kerne=
l.org/
>
> >
> > >
> > > The PCC driver above reads the data out of the DMA ring-buffer
> straight into
> > > the kfifo hooked up the the miscdev read callback. The datasheet
> > > notes: "the data structure of the FIFO is mode dependent" in the
> description of
> > > PCCR3, but no in-band or out-of-band mechanism (sysfs,
> > > ioctl) is provided for userspace to query whether it's 1B, 2B, 4B or
> "full" mode.
> > For the data structure in PCCR3, I checked with designer. We only need
> 2B mode to get the information about data and related addresses.
> > For example, from espi master send the port 80h~83h with first data
> 0x11223344 and second data 0x55667788. The PCC kfifo would be written in
> the following output from hexdump.
> > # hexdump  /dev/aspeed-lpc-pcc0
> > 0000000 4044 4133 4222 4311 4088 4177 4266 4355
>
> Right, but that's different to how the Aspeed snoop chardev behaves.
> Both the snoop and PCC features can be used to present the same data
> (POST codes) to userspace. There should be a unified chardev behaviour
> for POST codes so we don't end up with a mess in userspace to deal with
> the differences in hardware capabilities.
>
> If we've got a chardev it would feel idiomatic to me to have ioctls to
> configure the hardware to the required capture mode for the platform.
>
> > >
> > > The situation with the snoop driver is similar (1 or 2 1B channels
> multiplexed
> > > into the one data stream). It also looks a bit quirky with multiple
> channels
> > > enabled, as what userspace reads will depend on the host access
> patterns, but
> > > no metadata is provided to userspace about what it's reading.
> > Yes, for the snoop driver and PCC driver, some mechanism is the same.
> But snoop only supports 2 bytes data from the 2 1B channels multiplexed.
> > So, we need to add PCC driver to upstream for customer's 4 Bytes POST
> code capture usage even the PCC driver needs to check the snoop enabled o=
r
> not.
>
> I understand.
>
> > Or, could you please give us come comments about how I can upstream the
> PCC driver.
>
> Essentially I don't think it's okay that each driver implement a
> bespoke chardev, or that the devices don't share a common devicetree
> binding. I think what's needed is a small abstraction that provides
> common chardev semantics to userspace (e.g. /dev/postcodeN) that can be
> connected to the different backends provided by the hardware (Aspeed
> snoop and PCC, Nuvoton BPC) and act on the needs of userspace (1, 2, 4-
> byte POST codes, configured using ioctls).
>
> Andrew
>

--0000000000008a8759062eeff9f2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Andrew,<div><br></div><div>I agree that a small layer o=
f abstraction is needed to provide common chardev semantics to userspace. I=
 think that effort can come where both Nuvoton and Aspeed unify their desig=
n and agree on a common abstraction layer.=C2=A0</div><div><br></div><div>I=
 think such efforts may take some time for both to unify, is it possible to=
 get this upstreamed (after addressing all other comments) while both parti=
es work on an agreed unified abstraction layer?=C2=A0</div><div><br></div><=
div>Thank you,</div><div>Mo</div></div><br><div class=3D"gmail_quote gmail_=
quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Feb 24, 2025=
 at 8:27=E2=80=AFPM Andrew Jeffery &lt;<a href=3D"mailto:andrew@codeconstru=
ct.com.au">andrew@codeconstruct.com.au</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">On Fri, 2025-02-21 at 00:51 +0000, Ke=
vin Chen wrote:<br>
&gt; &gt; On Wed, 2025-02-19 at 11:59 +0000, Kevin Chen wrote:<br>
&gt; &gt; &gt; &gt; On Tue, 2025-02-18 at 11:11 +0000, Kevin Chen wrote:<br=
>
&gt; &gt; &gt; &gt; &gt; &gt; On Mon, 2025-02-17 at 13:00 +0100, Krzysztof =
Kozlowski wrote:<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; On 17/02/2025 12:48, Kevin Chen wrote:<b=
r>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0pcc-&gt;mdev.parent =3D dev;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0pcc-&gt;mdev.minor =3D MISC_DYNAMIC_MINOR;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0pcc-&gt;<a href=3D"http://mdev.name" rel=3D"noreferrer" target=3D"=
_blank">mdev.name</a> =3D devm_kasprintf(dev, GFP_KERNEL,<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &quot;%s%d&quot;,<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; DEVICE_NAME,<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0pcc-&gt;mdev_id);<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0pcc-&gt;mdev.fops =3D &amp;pcc_fops;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0rc =3D misc_register(&amp;pcc-&gt;mdev);<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0if (rc) {<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_err(dev, &quot=
;Couldn&#39;t register misc<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; device\n&quot;);<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0goto err_free_kfif=
o;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0}<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; You cannot expose user-space interfaces =
from SoC drivers. Use<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; appropriate subsystem for this with prop=
er ABI documentation.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; See:<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; <a href=3D"https://lore.kernel.org/all/b=
c5118f2-8982-46ff-bc75-d0c71475e9" rel=3D"noreferrer" target=3D"_blank">htt=
ps://lore.kernel.org/all/bc5118f2-8982-46ff-bc75-d0c71475e9</a><br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; 09@a<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; pp.f<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; <a href=3D"http://astmail.com/" rel=3D"n=
oreferrer" target=3D"_blank">astmail.com/</a><br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; and more discussions on LKML<br>
&gt; &gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; &gt; Further, drivers/misc/aspeed-lpc-snoop.c alre=
ady exists:<br>
&gt; &gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; &gt; <a href=3D"https://git.kernel.org/pub/scm/lin=
ux/kernel/git/torvalds/linux.g" rel=3D"noreferrer" target=3D"_blank">https:=
//git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g</a><br>
&gt; &gt; &gt; &gt; &gt; &gt; it/c<br>
&gt; &gt; &gt; &gt; &gt; &gt; ommit/?id=3D<br>
&gt; &gt; &gt; &gt; &gt; &gt; 9f4f9ae81d0affc182f54dd00285ddb90e0b3ae1<br>
&gt; &gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; &gt; Kevin: Did you consider reworking it?<br>
&gt; &gt; &gt; &gt; &gt; Andrew: No, I do not rework it but add the post co=
de capture<br>
&gt; &gt; &gt; &gt; &gt; driver using the SNOOP registers. As a result, I a=
dd some code in<br>
&gt; &gt; &gt; &gt; &gt; aspeed_a2600_15 to check the SNOOP enable bit. PCC=
 driver probe<br>
&gt; &gt; &gt; &gt; &gt; abort if snoop is enabled.<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; Hmm, I think OpenBMC&#39;s history regarding POST code =
support caused<br>
&gt; &gt; &gt; &gt; some confusion on my part. For whatever reason, the sno=
op device was<br>
&gt; &gt; &gt; &gt; used as a source of POST codes despite the existence of=
 the<br>
&gt; &gt; &gt; &gt; dedicated POST code hardware since at least the AST2400=
, but...<br>
&gt; &gt; &gt; What I know about the dedicated POST code hardware in ASPEED=
 should be<br>
&gt; &gt; &gt; the same one in LPC module.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; PCC is used for port I/O byte snooping over eSPI.<=
br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; ... it seems that they&#39;re largely interchangeable, =
just with<br>
&gt; &gt; &gt; &gt; different hardware features (PCC has DMA)? My impressio=
n is that the<br>
&gt; &gt; &gt; &gt; snoop device could also be used over eSPI?<br>
&gt; &gt; &gt; Yes, PCC has DMA to capture the POST code.<br>
&gt; &gt; &gt; And snoop device also can be used over eSPI.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; These two devices of PCC and snoop use the same port I/O of =
80h and<br>
&gt; &gt; &gt; 81h.<br>
&gt; &gt; &gt; But, in current usage of PCC, it can support a continuous, 4=
-bytes<br>
&gt; &gt; &gt; maximum region from port I/O 80h to 83h.<br>
&gt; &gt; &gt; What I know about PCC or snoop usage, depends on INTEL platf=
orm or AMD<br>
&gt; &gt; &gt; platform.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; For ASPEED, we want to upstream the PCC driver for the PCC u=
sage.<br>
&gt; &gt; <br>
&gt; &gt; Yeah, that&#39;s fine, but I think some work needs to be done to =
provide coherence<br>
&gt; &gt; in the devicetree binding and userspace APIs across both the ASPE=
ED snoop<br>
&gt; &gt; and PCC bits, as well as the Nuvoton BPC. Bespoke designs create =
pain.<br>
&gt; <a href=3D"https://lore.kernel.org/linux-kernel//7661de74-f68c-6617-6a=
4e-3b0eb76a2a2e@linaro.org/T/" rel=3D"noreferrer" target=3D"_blank">https:/=
/lore.kernel.org/linux-kernel//7661de74-f68c-6617-6a4e-3b0eb76a2a2e@linaro.=
org/T/</a><br>
&gt; Andrew, I find the &quot;NPCM BPC driver&quot; to get the link. Are th=
ese patches match what you mentioned?<br>
<br>
That looks about right.<br>
<br>
Note Rob&#39;s response there about disparate bindings:<br>
<br>
<a href=3D"https://lore.kernel.org/linux-kernel//20221130193014.GA2645083-r=
obh@kernel.org/" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.o=
rg/linux-kernel//20221130193014.GA2645083-robh@kernel.org/</a><br>
<br>
&gt; <br>
&gt; &gt; <br>
&gt; &gt; The PCC driver above reads the data out of the DMA ring-buffer st=
raight into<br>
&gt; &gt; the kfifo hooked up the the miscdev read callback. The datasheet<=
br>
&gt; &gt; notes: &quot;the data structure of the FIFO is mode dependent&quo=
t; in the description of<br>
&gt; &gt; PCCR3, but no in-band or out-of-band mechanism (sysfs,<br>
&gt; &gt; ioctl) is provided for userspace to query whether it&#39;s 1B, 2B=
, 4B or &quot;full&quot; mode.<br>
&gt; For the data structure in PCCR3, I checked with designer. We only need=
 2B mode to get the information about data and related addresses.<br>
&gt; For example, from espi master send the port 80h~83h with first data 0x=
11223344 and second data 0x55667788. The PCC kfifo would be written in the =
following output from hexdump.<br>
&gt; # hexdump=C2=A0 /dev/aspeed-lpc-pcc0<br>
&gt; 0000000 4044 4133 4222 4311 4088 4177 4266 4355<br>
<br>
Right, but that&#39;s different to how the Aspeed snoop chardev behaves.<br=
>
Both the snoop and PCC features can be used to present the same data<br>
(POST codes) to userspace. There should be a unified chardev behaviour<br>
for POST codes so we don&#39;t end up with a mess in userspace to deal with=
<br>
the differences in hardware capabilities.<br>
<br>
If we&#39;ve got a chardev it would feel idiomatic to me to have ioctls to<=
br>
configure the hardware to the required capture mode for the platform.<br>
<br>
&gt; &gt; <br>
&gt; &gt; The situation with the snoop driver is similar (1 or 2 1B channel=
s multiplexed<br>
&gt; &gt; into the one data stream). It also looks a bit quirky with multip=
le channels<br>
&gt; &gt; enabled, as what userspace reads will depend on the host access p=
atterns, but<br>
&gt; &gt; no metadata is provided to userspace about what it&#39;s reading.=
<br>
&gt; Yes, for the snoop driver and PCC driver, some mechanism is the same. =
But snoop only supports 2 bytes data from the 2 1B channels multiplexed.<br=
>
&gt; So, we need to add PCC driver to upstream for customer&#39;s 4 Bytes P=
OST code capture usage even the PCC driver needs to check the snoop enabled=
 or not.<br>
<br>
I understand.<br>
<br>
&gt; Or, could you please give us come comments about how I can upstream th=
e PCC driver.<br>
<br>
Essentially I don&#39;t think it&#39;s okay that each driver implement a<br=
>
bespoke chardev, or that the devices don&#39;t share a common devicetree<br=
>
binding. I think what&#39;s needed is a small abstraction that provides<br>
common chardev semantics to userspace (e.g. /dev/postcodeN) that can be<br>
connected to the different backends provided by the hardware (Aspeed<br>
snoop and PCC, Nuvoton BPC) and act on the needs of userspace (1, 2, 4-<br>
byte POST codes, configured using ioctls).<br>
<br>
Andrew<br>
</blockquote></div>

--0000000000008a8759062eeff9f2--


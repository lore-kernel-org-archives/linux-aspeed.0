Return-Path: <linux-aspeed+bounces-4675-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4782C5AC82
	for <linux-aspeed@archiver.kernel.org>; Mon, 10 Aug 2026 10:37:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJWQh6fvCz2yrS;
	Mon, 10 Aug 2026 20:37:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::432" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786358220;
	cv=pass; b=iAM78xJUHsPBf2Cky8m8Kfm66lBNYyYcGQXhW1WWuJ0gWCMFPZdpG8FX9I0jrbB2TYcx2NlxeRQNQrHyDXTI5FWX8VURLI6uZ8KUOlXMrXuwbXmkEbtAfxP7aoRUnCs6UIgkWM5ytuAA0uO1I9TZtdJ0xtVx7ONrny0aFYCNxHWjZiOSzJ2NbPrsCTunUQrEtpY81QMEMjfeI3QGw8yhDjLzKxY2a5Rls76jlfydBOdcWydgey5n4aR+M5yXGG9oJsePOF5syoa/Jh3nrUF0BTvIBorAguO8tQcOdt/LsT17F+1ColblVVqj7AV/56hkuKzq1puifA5wFZXExL1FHQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786358220; c=relaxed/relaxed;
	bh=JZiFErJumO4f6l/jB3Vv8dc/wBPU8PfaQ8eqWXYPx/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gdYjigViXL8/xsBdansr71f6RIuHOnKmkvzMODSoDgrmXyw6Qxa7qfqw8SBgJ23g8pp0C6TJY9S8p/+Q8DuiNniF1TbZNOky3tpAi56qEI5/wUG+ztqm+xy7pNPYKKPf+hF7dtgyzlB+IAyKMIJMd4WD2oiX480uqsGExfTo7sKuji7lele3JTbnd3WpLFks+ITENLvV62LRHO9NZosStFOvw5j07Fld645PsnO16VLpWo4ltjYquGQRzdlLz2jqmJWImfeSoC4jWwqOLgD6yA5d/nuRuC65c5Uca6Bw8htfLSWBkJ+WRCg53FtaZOZnHBiOT7OtSW8p0+u9XNtmFg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=Xe6L+eeN; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=Xe6L+eeN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJWQd4pzqz2yrL
	for <linux-aspeed@lists.ozlabs.org>; Mon, 10 Aug 2026 20:36:56 +1000 (AEST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-480033bdcf4so921538f8f.2
        for <linux-aspeed@lists.ozlabs.org>; Mon, 10 Aug 2026 03:36:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786358212; cv=none;
        d=google.com; s=arc-20260327;
        b=LXnwzcoLjxM6MGCgXxN68DM50Uv+h4VTbUajv6yPQY2VcsgU2/kOQDy7rkFxN1+Gb+
         FNQ/GJ2MfHbCweiI+1cw4AK2k/Xn3fvL+qnaTyXZ2n6fZ+5SZRKmRxafDI81IjUEikw4
         V/LHw0FJZFe+v+d6B8vC3Catlztc6m/ACfJq2PEXs6NnBuIfnl+DK1Rnz1ZFN+WxJ6WH
         wHVANPjbYnLZ6zukROUHgD7OJ7f1BW6S0XcWsiOzrUTsB04rI/UmPwY7L6otDjleIrQK
         1mM3zdGLAdQjqqXqDCMDxFHVgjh0LrgoJ5ZskfW9tcCXstCkYPQcPqhq8lkjsY/9FH0H
         YXiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JZiFErJumO4f6l/jB3Vv8dc/wBPU8PfaQ8eqWXYPx/g=;
        fh=9Ul170QuMsvavraEYL8EpMirNe39eNz4a2Ybt4z9suY=;
        b=ix0JSCMJ5OhigCJOATehlpjhHib47i7y/fth+rGtW4ycgrNZFpqee75BXRRVvI87ey
         2yWiMXQmT74sCYcacM+ob5TdXwzCncFt58zXSQAhBB50UUJwJwHbJPMNRJnYqT8QbBo4
         r1Zx7Qh80EVXCFq/LGaABtOyr3tuS7rUr1FW5JxojIwGEslf3o48op+mX3H88ZhI3kej
         I8KpeHQsfC4BdgX5rgg4G2TUMMy5M6uVSPho0VCa74WgNi4V0uhNL7YYCq/tEYOhpidn
         bqnPkPZO5PYP7ZKfgbZRHcQbGnYhiK9HfrIXw5rwVEBtVVfAfHl+ieZA5M2QD13OjUIT
         MV8g==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1786358212; x=1786963012; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JZiFErJumO4f6l/jB3Vv8dc/wBPU8PfaQ8eqWXYPx/g=;
        b=Xe6L+eeNVjH+uZtKG+Kup+bZbaDspO1f63VCP1hWOerW/ZwGWBZZckfKpit9vUIlCb
         dEwPlItltY+IkZ0/VjNZfgMAlnWY1LSoM4HgwpUe0xoQOBwLqPQJdm8C3aiX7zowNtu2
         UI/6okNWXauTzHWgpKTy44DOTlaMkCGwDHERCif7R5EfmMI+f2U0utrlhwOiibpdUiAK
         P/Cz58daeMmSvM/yS/heQsNzutaqA85lsDpAJ2o8pihbh8J51GCeo1uQPUiqv5Ca65WO
         EClpLeYSGJOvBzHfgjVJp7NqgwRqLlN/vghozErV7+qv8iEXQ1Q3MBQo1rJxw+j0KBmJ
         jGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786358212; x=1786963012;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JZiFErJumO4f6l/jB3Vv8dc/wBPU8PfaQ8eqWXYPx/g=;
        b=OgCVDAPlY2x2cTBT9JhbDgzVSoDUytWHoJTYJOU2PpX9+hIy+TPFGUspS2RI3CVsQP
         c1GQt0mF2zV+1QyUylPOFHNCKm6DjtVD6RcBUAM8po8y4NN+kCimpVmay2nLB98kL9DU
         zJW4QeKROwr8s10PUrujhq0bDbAb62+TV8qvkIG5CCG0HYv9BvdDobc/GgDwfm4fAOHw
         FZWA1+NR4z3lie1D3GJ9y4bwcw/9PitD1SPXmS+VzCSeF50vmMp2FdGghNO8yZH+TR9S
         WdTLcVoyh0lfrFEhkWkti54IDodrVTecCUyLGFLbdB7bRG3yrPx0tTBx4o8H9yHde0Sh
         rH7g==
X-Forwarded-Encrypted: i=1; AHgh+RrW4Ft9xCe4jQT/5cLCAVvX1852q54aZHph0GxHh6HyBAEmp9qjLdF5rz7PqUBQDer8lIevzmgIs7IoOtM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw5SAOU241He4kMXoukaBRE0RfJLGMSO/wQfwlnO+HRA5eA5fj7
	85+17dVobxXirEiFXDLvcC7sDSuhsGni/rHdeNQFFfdsf/QwSm2XfW/Rg54nUNcMpnFwF9JB8iP
	Vix//58ObKpek8e1pUc/ST+0WV/70A6+rGQVsp1o0cA==
X-Gm-Gg: AR+sD12WLlOJyjQuyEc9Q8WCxwr8ciWj/UYYlQaxXNINsdl/dctnUJnVH7z+j/WgSJA
	i0N/SdZuX538TiQ2BkFa7fdHsZksXtAb7i8Gk213ddNlmtF9kD0gdc6zVlEJC1X8vR+uB41sKqT
	CYviBlE4o8dSV168ihkB5CCcoQ+3f3uG/fhOQRdbf6+EDxxIxxYccm8Es2niZS7llfT/DtPEOdr
	e0tJla7v9+jy17iC28a1i2yicW5afM4A+V8TA94xYos5wmGkaMdFao4MdW0sAQnKbHzxoOrXquT
	41bCY4XFOZ4Gg8caXCJ6l66lsc6m8vrJjWS090gWF1IzBM50zfufgUC8EoSXM6v6ZYSOdMLCTFB
	Ru8f/QpK0RBMvEUPkJxnZIRYOAxjjfA==
X-Received: by 2002:adf:e012:0:20b0:47f:959f:f69c with SMTP id
 ffacd0b85a97d-481455ce280mr1198921f8f.7.1786358211845; Mon, 10 Aug 2026
 03:36:51 -0700 (PDT)
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
Precedence: list
MIME-Version: 1.0
References: <cover.1785932211.git.gregoire.layet@9elements.com>
 <51db5e5bb5bf44dd5ab893b8d547291f04e1d3c7.1785932211.git.gregoire.layet@9elements.com>
 <178609182923.193353.7287772568467157519.b4-review@b4>
In-Reply-To: <178609182923.193353.7287772568467157519.b4-review@b4>
From: =?UTF-8?Q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Date: Mon, 10 Aug 2026 12:36:39 +0200
X-Gm-Features: AUfX_mzXwFrJ-NjND3MQzEP6QwRNrCstHPVctQ1cLuVCmYnxx742CiD2MW3y8Ss
Message-ID: <CAFi2wKZdJ3LxJVDqC2K79T0JhoOOWSj=ZmL9pB+Lka_aXDXatQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] soc: mfd: add ASPEED AST2600 PCIe BMC device driver
To: Tan Siewert <tan.siewert@9elements.com>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, lkundrak@v3.sk, 
	devicetree@vger.kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, lee@kernel.org, 
	=?UTF-8?Q?Gr=C3=A9goire_Layet?= <git@gregoirelayet.com>, andrew@lunn.ch, 
	jacky_chou@aspeedtech.com, yh_chung@aspeedtech.com, ninad@linux.ibm.com, 
	anirudhsriniv@gmail.com, linux-serial@vger.kernel.org, mfd@lists.linux.dev, 
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > +
> > +static int aspeed_pci_bmc_device_setup_vuart(struct pci_dev *pdev,
> > +                                          struct aspeed_pci_bmc_dev *p=
ci_bmc_dev)
> > +{
> > +     resource_size_t bar =3D pci_resource_start(pdev, 1);
> > +     struct plat_serial8250_port *port;
> > +     u16 vuart_ioport;
> > +     unsigned int i;
> > +
> > +     for (i =3D 0; i < ASPEED_BMC_VUART; i++) {
> > +             port =3D &pci_bmc_dev->uart[i];
> > +
> > +             /* ASPEED BMC device shift addresses by 2 to the left */
> > +             vuart_ioport =3D vuart_port_addr[i] << 2;
> > +
> > +             port->mapbase =3D bar + vuart_ioport;
> > +             port->uartclk =3D 115200 * 16;
> > +             port->irq =3D pci_irq_vector(pdev, vuart_msi_index[i]);
> > +             port->iotype =3D UPIO_MEM32;
> > +             port->type =3D PORT_16550A;
> > +             port->flags |=3D (UPF_IOREMAP | UPF_FIXED_PORT | UPF_FIXE=
D_TYPE);
> > +             port->regshift =3D 2;
> > +     }
> > +
> > +     pci_bmc_dev->cell =3D (struct mfd_cell) {
> > +             .name           =3D "serial8250",
> > +             .platform_data  =3D pci_bmc_dev->uart,
> > +             .pdata_size     =3D sizeof(pci_bmc_dev->uart),
> > +     };
>
> In the commit message you're describing that the MFD driver will be used =
for
> setting up MSI interrupts:
> > It doesn't bind the whole PCIe resource to allow each sub-driver to bin=
d the
> > needed addresses.
>
> But you're adding the UART devices here which now means that the core dri=
ver is
> doing more than MSI interrupt init.

I might have misunderstood but this is creating the UART device by
using the 'serial8250' driver.

> the core driver is doing more than MSI interrupt init.

Yes, as the core driver should add the devices with the right drivers.
I will add this in the commit message.

> Suggestion from my side would be to have an array of `mfd_cell` where you=
 define
> which devices are part of the MFD,

There is already such an array, it is a one element array as only the
VUART is done.
'struct mfd_cell cell; ' will become an real array when KCS will be
added afterwards.

This is not an 2 cell array for the 2 VUART as the 'serial8250'
manages the two VUART on its own.
From what I have researched, this was the way to add UART devices from
an MFD driver.

> and your VUART lives in another driver.
> See `ls2k-bmc-core` for example.

The UART already lives in another driver: the 'serial8250' driver.

Regards,
Gr=C3=A9goire


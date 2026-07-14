Return-Path: <linux-aspeed+bounces-4467-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D889CC44507
	for <linux-aspeed@archiver.kernel.org>; Tue, 14 Jul 2026 06:46:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzqbd1ZN4z2xqn;
	Tue, 14 Jul 2026 16:46:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::42c" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784011613;
	cv=pass; b=KINdFP12442TH5WJUbXPhPfn50VSYeskfLzbcbiFO6kqZkryFj2dcPBuVYWwUyC+9H6Dno1mzGb5xWJI6JsnsEuqrr05EWoPazLztD1CNYFPos1BUgk2TR2/WQyTQeTj8EqsuzZLxHunYauV/F0UI4uzZvwc7DRv5rddv+Uls1N2NsVE9/27Zu5O2x8tZbiJT4HxHwC/X5hIas5KDl/wdjY/YY8qeFyVt69AkRu6xnNcX66hOPi4aQ8XhMFUja5eRVkcYMQk0sBNX0ip7TFVx+xLbiWkSIW6lkJbQtDKhlcrQ+FFeWldGNP4RcDJA9jmggTjy4M7Ecs/bo6nuikn1A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784011613; c=relaxed/relaxed;
	bh=eRIKFgzkF61kYnLz7Ci2gKmTsN7do9uyOR/32IqtdZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ex/tnDdlawM2PcCDbNdBWTw09bMgWLLCPVeLlky65mTeo5f2BEy961bPwplRAzkser0TGv7nGZ3XGantlJn+ikkrdArNG7PHCUdHEpM7X+j8Htyp5CWVwh32M4agLS2iVcAnFulR/UVeHQw62YFuh9GaNi2pfHI/Fmu/eW1zq/ceY1u/kb21I10MsQPXmHc1MZNW1/njsnPxGLhqUkf/AaXFNHs3ZAGxQWagL+LVmE4R+WammfhKHOlZbIJWRHlA3rNWwn/W5Xgs2F9VVGSPy0jTi2fAglkPQqmD1tU+JngoyU/CQVu3KcAevD0PvwnTUpHm7TEY3a21eLpGm7/ipw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=YjCm9QAe; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=YjCm9QAe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzqbc1BjDz2xPb
	for <linux-aspeed@lists.ozlabs.org>; Tue, 14 Jul 2026 16:46:51 +1000 (AEST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-474560436c3so465552f8f.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 13 Jul 2026 23:46:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784011609; cv=none;
        d=google.com; s=arc-20260327;
        b=HQLwt5HabHmLJ36qN5qcOwqE8Zcz+Ag65uzN72WxcNvU5Ie5ZlgS9z/wZepI7Chpx+
         3VCe1O3i/80ZkrcUA0Kp+P4yyH4xGTlpGZxyZdynib6Liy6Q2zrvzu3Efoq4tyFpWZSj
         lPIdm3nruYi5HW6EUvrLRukt3dJQVMyrfQ6FMLfTF6i6GNYQ70bXJx+vDMc2ZORJd73Q
         dRxH4UdoUJmgN1Mk7l1oh4CV6akiszwgZpaOxppXFBlwiQaN7IwBYOzOd8GpA16PHIct
         fCRQ3cqONYieGQQLFYXvL3Ge06IjyZJ8m0hz834uiQqUv4n/lH++Aj93XXFX7Z2xLJCT
         jpRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eRIKFgzkF61kYnLz7Ci2gKmTsN7do9uyOR/32IqtdZ8=;
        fh=Kv+Y23j/Apjc42smYg+xHu9raG8RN01SvllpX9fVj4g=;
        b=k1pP5yi++5X8LZzj/b/lZqgnWpK2mmlp9MD47sg1g4FBGAYsgvdIgxZQiB63tQJvwE
         7LymOAOk3yKTH4fy6LmcFSexu6H+4ObHFwMKZSH84Evh8rKlsoMaCIeostES8zVKpK0O
         MrhJgEvCdf205hvAOp1cQt7BC1oX/HFNl5iwthJoSvX31XNTmUKvvSK3LxKrL+y6YssR
         claiF/F+S7uRSDbHQY2vUo+dfn38MwCiCI0SPAlL8ngIkOuorASyfX5GKsMOkHaoGOwh
         T+QG5yC8heb87bPpSV7gPGH3UmpRoGa4klrjjkK2LU8v6Ng5NqPYdBDkaMPotHOwTY0/
         kQOw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1784011609; x=1784616409; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eRIKFgzkF61kYnLz7Ci2gKmTsN7do9uyOR/32IqtdZ8=;
        b=YjCm9QAeKXy8EC4tLtXQBahD681ALIs4fU0wy4ACFa1NfqUPVoRj4hwVUz9/ngszPS
         u9AdfQ+EVXB5PrJvT1rgrhfTPZwC1mLJWLJTi3a+PTebZ3F9hZWhCPTgnOWp8+jRA8mU
         G9t/BLS70f6qTsnyaqy9H9fcz5FjgA+q/uEl+BJbQShbTBtpJn6O5N098yuBp5GOjiCt
         +lqQLQpwdlKH60VSpyShGHQIwfKUbnpfLRFDbwqKAfp1B6biOvtfL24MIBQ+mZ8y6yVu
         JiAU2DsayHGjPnFRLnbJZmF6l/Xrvq7eaOqLyvF2nq85AlmSib1fF142vuvfAmFtpty8
         Pkzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784011609; x=1784616409;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eRIKFgzkF61kYnLz7Ci2gKmTsN7do9uyOR/32IqtdZ8=;
        b=FGkBsnns29aV8fgmqOMnQB6Pw7wXfRDFOAP2fq11jw0vQ7vIFYFJoKHOkkLAqe6isB
         pG0EOIUdcpnwP+8tu7bMR3pnISffsupEdjZNxO60G4NXUPJsEO7xZhM5KqLsH1rGWSFT
         xx/Aot83xdN7wpqnTLNEu+g34vIKvXMw+7z4TgDnccT5ITQAV+vM/MERZPnwDL77cHX/
         ffkovsDLc3L1/+l0fOaYjGmQKaToCl+Dv1FMtGupDmC69vaKH/FT/VJ5kVtfWIRy0tMw
         S0ynUAKnKjzqLfcLarTgFFwk+e3ESAGJrnVJBMgSN4OnP0SRFF1j631mL18+RbK0eEX2
         VcBQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp+NXFRVk0knhA5vbeVR913zqTEF2NUcuvtCXO+0/2n/voEoXAEKNksOYQvsZQk6pVRlqe1FxMn1nw2Y+8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy4Tr7OH6yYs0p6JpDd09+ae1YuWExrB1K3qsKRo/YIDmesH1pO
	gc45HOdnb0YiDP2+jZyDykwfbxHG89Zr8EuC33PAmhWQIifZuUk0MsHoAt90AsjPGCDDH/fdB4J
	FS2gU+R2DVMs+6Z79i5+WKiu+Exc6U9vEPyv0r7oorg==
X-Gm-Gg: AfdE7clr/DHUR7kJCLiqDuNv185WpBQV4XiwURU608PZ++p0F5iJlrCtA0f9PvP2hSH
	ojvFxW5INHGeLrZUJuIL2KUWJDmcrRJINWJcBdrdoxX6HqA6aeV7hXXxj1YFaDMjD0xRkCnqQFk
	CEvTzJ8sjDfhmNSlhKq53mKafWUKj31cpcrxNk8Qf8DM9a6LIlr9+2fKVwwzvVr7PSvCD5wX01R
	x6B0+cPpwoMfOchFnoXHlXiJcAKI3C/Jh3XtHuEQuTR1u43F0XDWMlvjONd3eJu8jLlongvgXTZ
	+hFoics55aGRKfKFn6BxK8WGLn23jXyE6mtO4Sw0/A0Oh3NyuehcjVNkrw==
X-Received: by 2002:a05:6000:2c03:b0:46f:f12b:e457 with SMTP id
 ffacd0b85a97d-47f2dcc333cmr14446794f8f.21.1784011608749; Mon, 13 Jul 2026
 23:46:48 -0700 (PDT)
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
References: <cover.1783524645.git.gregoire.layet@9elements.com>
 <51e455417bdcfe608270c6cb2806b1fd971fb998.1783524645.git.gregoire.layet@9elements.com>
 <eaef5bcc-99df-4549-8d37-fb3d127c414e@kernel.org>
In-Reply-To: <eaef5bcc-99df-4549-8d37-fb3d127c414e@kernel.org>
From: =?UTF-8?Q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Date: Tue, 14 Jul 2026 08:46:38 +0200
X-Gm-Features: AUfX_myOLR4_eYCcAMsMsFbuxCuEv8cibreksrI0hciTFLsi2wYi7z1DbvBt6s4
Message-ID: <CAFi2wKaO9ea77KP3hjoaruMgU8oVbbtuAmXK8p-12HRdRFOACQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] soc: aspeed: add host-side PCIe BMC device driver
To: Jiri Slaby <jirislaby@kernel.org>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, lkundrak@v3.sk, 
	devicetree@vger.kernel.org, gregkh@linuxfoundation.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, andrew@lunn.ch, 
	jacky_chou@aspeedtech.com, yh_chung@aspeedtech.com, ninad@linux.ibm.com, 
	anirudhsriniv@gmail.com, linux-serial@vger.kernel.org, 
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiri,

> > ...
> > +
> > +enum aspeed_platform_id {
> > +     ASPEED,
>
> What is this good for?

Unecessary, it's removed now.

>
> > +};
> > +
> > +static const int vuart_msi_index[2] =3D { 16, 17 };
> > +static const int vuart_port_addr[2] =3D {0x3f8, 0x2f8};
>
> Sort of inconsistent spaces. Both arrays should be unsigned anyway. And
> for the latter, u16 should be enough.

True. Acknowledged.

> > ...
> > +
> > +     vuart_ioport =3D vuart_port_addr[idx];
> > +     /* ASPEED BMC device shift addresses by 2 to the left */
> > +     vuart_ioport =3D vuart_ioport << 2;
>
> Simply:
> vuart_ioport <<=3D 2;
> ? Or join the two lines?

Joined the two lines.

> > ...
> > +static struct pci_device_id aspeed_host_bmc_dev_pci_ids[] =3D {
> > +     { PCI_DEVICE(PCI_VENDOR_ID_ASPEED, PCI_BMC_DEVICE_ID),
> > +             .class =3D 0xFF0000, .class_mask =3D 0xFFFF00,
>
> PCI_CLASS_OTHERS << 16

Acknowledged

> > ...
> thanks,
> --
> js
> suse labs

Thanks for the review. Applied everything for the next revision.

Regards,
Gr=C3=A9goire


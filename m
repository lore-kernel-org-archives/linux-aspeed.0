Return-Path: <linux-aspeed+bounces-3876-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E51C710FC45F
	for <linux-aspeed@archiver.kernel.org>; Wed,  8 Apr 2026 22:55:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frdgd2k8Qz2xb3;
	Thu, 09 Apr 2026 08:55:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::32d" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775642783;
	cv=pass; b=PmBgY0aRoylb4DKnvqwS+IMT+UYnUm3IWmpi6U/x1/46iWc3wEVah2eE5oEE+obvgpFYeiyrla7DDTnXI1u8bkTfyIXVY0po8PbcGk/KTj4Qc68ciSObrgwQX3aRcXeCCCdqC1Rui6CIzCBXTYTS2w7SmJRe/2zDVdAmKzs3QnyLX2e8CKuIi7JwpxPico3BePzqzYwJpi7nkCNtCTEZaeuGudiScuLZnWyVNX/d8a/4kYRWZLDw4TReUobExAOAf74sYk1K1hYhxvFOUs7ZPeGknrKB1CVNkD23s+aYxQOWxgGSQy0LydQNOmE1LDmjWWmavZo1oAmAjkUYNLjBEQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775642783; c=relaxed/relaxed;
	bh=vcyUmIQWBRIN2bVxClZ8Li2ITCNwZ/GpA68S4b0OhXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RbJsReplHyJk/bqL+I0INNKKt2/lUX2cFlJSFBl+eUFj0hk87bBZyM9U9Nctq1HLlgTO6iKKBM6XfnxrgQlimj8udS2gUguLe7U3XwP3R9CZp41kaCzTmv3ArBJbN3sU2mJ1AshkGNHsA8nhia696V6Xtw9NOMO2BO5dayemaj4z+wekMKbz6tK05kKg3fL1Hi4gr5/DwVHLgaF7wet32kR1/FGUXnCUUm1JJPiPubvGK+j8No8DN3MN+fpeQjuqT/K8UDxed3s5rG16ZXqb6ob1APrjnoim6dwrUqD5XuOTRd9TQ8Nr9TAq/F6buYt4WULXa1kfbcsofMlGN0H5zQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=n2mAp/2k; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com; envelope-from=pkleequanta@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=n2mAp/2k;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com; envelope-from=pkleequanta@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frJcY4sZ9z2yC9
	for <linux-aspeed@lists.ozlabs.org>; Wed, 08 Apr 2026 20:06:21 +1000 (AEST)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-7dbce74e537so3316990a34.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 08 Apr 2026 03:06:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775642778; cv=none;
        d=google.com; s=arc-20240605;
        b=XJqhbeUgZIux5fFeBdJdlfium92+6V8bVePYvKDat9DtRfkBjHw8bubAUtGqVAKdi2
         7Oe1BtpaCAH+OLGWA0M/Bw1fOU0GGC4ZuYS6T71DNKXAwUFKc/gnuisaYYS+riUenE46
         bn7NezQZm5etguooo2MK5S+bUWhm+y5TorNHNpslSWbK8E347zEsNqHcJ3ZHA3oeuzkl
         Qw5jpR2h3eOfrVApkARn1Lmyg0ExW7EZBUF7bygAiZ0mBtNz0kL+FycFh73DKr7CpSlP
         y0/+4VXQkQA7FgkToaATwCOUosfoo9li8qj3GWR2GTkN77m+SUDmpu8y5WgJNtyp15sf
         +S0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vcyUmIQWBRIN2bVxClZ8Li2ITCNwZ/GpA68S4b0OhXA=;
        fh=ozeMQFr31W/YjnGsFnqPPCcZrou0rKkBQ3YSAjgyOWo=;
        b=HcCPMLsVYPvYWvTaS3JBQ3RkNQSksq0Qgt4DiS5MC7xKqHQ4BCFUYDrVW6jRpvbfeF
         reZpjMfM/eu+rYCDlVsNECTokz0uLqCljoxqEzI61xQjPnwgHrQ1tj8JashczRlGvC+i
         /gu6+WJJisrZs4uk7HPQ5NIXlBZYpRqcz7zq+WMV851gF9NSNvo4eUyTnkHCmpGJbWXO
         3PVHkmTDpCgXO7FgW2twLQr6FOm5iTcwWtnyj5Ood9ERUwA6Yoekb/RnzoBYqntSZJJc
         oKx62SmAg/BvGFfIyKE/Tm9zMTqYWx5BfUV3UtdHGXB1ggZG2HHMZtnleXwBaH9nJEgI
         QRkg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775642778; x=1776247578; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vcyUmIQWBRIN2bVxClZ8Li2ITCNwZ/GpA68S4b0OhXA=;
        b=n2mAp/2k2tBWTMwIO18nYHpqS3VTQ1YOT2qcw5u2z+puNRGxkgvpqXTwxtZ//hkbQM
         TQl9StxvgjFe+5+sSkBsWMUwJ0B8Sh+XcYh1TAwMg0mnrHgVBVIJQpuqVgQ4yJa5A7y/
         8Y5WkMt5SyQLPIc72JwUJN6obUuXQwMA1Kdgni+dhwfljAW3DE6ZqRSEGavwChGWZpmP
         QzZajDJRI2Y2sXd9ma3qPixXakFsvubrZXelP9k4NpRPzXuXqXgxF8Aingiv+iWWzUNb
         cOrYF+bVnOrwiD3NMfFHuoS7CAraK31bwJqvhLmQ41Aq0KHM7Sc3/QIirkCBe5Nq3GNf
         ltIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775642778; x=1776247578;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcyUmIQWBRIN2bVxClZ8Li2ITCNwZ/GpA68S4b0OhXA=;
        b=HrI2UwLQy+VnoZJTM1w1lrq0mJdQm6QU8aNZELKbRi1u3IO4MXn+7ggaJF3yBp9Zf2
         w87kTWw5nweJ4kWZNAOZHsFo+s7eMmzYttNv4Yr9tVeZQWCzA3wmeX1+JvorV4O74YkT
         kDZYXNjAuvz3wo1sNNs3XsWyr4Mv0XN4GcXnYXL4bY/sTvezFehv6fDiU4mEi/g43GIs
         xMlkNaGd5flUenyMKXPtmCkB31xvrNGEuzNe6ILrwlfEI1bb1o7eUVG1GpbMA9rdDPIO
         SOxhmbrhOoVEgysntQWREMrjYRsV5GRabSekx3c3ECAow+dutnqGoVp0P5EnfeqfdTaF
         p8rg==
X-Forwarded-Encrypted: i=1; AJvYcCWk2zZXaC8KygXYPWrckdz3cxCdWq+HRNZd3DjbcNgsHEvG/uNUhcL49DBpxkf3Z+cip5eXHCg+irNkto8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwtdsqcH/iKINFvq7u9spXmu8mdDADMWCy58Dr6vVOgwlWzp09M
	pfvI+eU/5mCJ+Z38cIVg6WUHrsGMfa9TSDhbt7jngqvySDS26bzHEjnmQs2dgXG5k8inceyKePN
	O3r7J24YRMeCACGQjVL5c+pRT8VELEAw=
X-Gm-Gg: AeBDiesWr18cOOR/X7lcjNn751iQUhbstMZyVKNtvujB6iLdkVthSxzc1FbMt3Zm6MA
	oxsz2iHamxoy0/b5+Lr6kmEXNsf/v+5qTnoy5lSEEqA53c3t/0CZTXzMIfw6oKYnh+l6/BSxoE7
	8OwZ0f2zeq/Hvg295SfLveD4dbwnDvHzLLAGH+UNNzbrKaHXKCBYGh1b5h7rdU8ul0Van+P+yDK
	bMJ2qdnEDpqVXWxvyvzQ4XBTp4MU7IzZENYFAJzO2uXWhr2Xj+/gB/BQOsy/9fbtjXGp8N52fjN
	PNzyE36fSosZFHDEjUA=
X-Received: by 2002:a05:6820:4c81:b0:689:dfc8:5e39 with SMTP id
 006d021491bc7-689dfd7aa8emr204810eaf.43.1775642778479; Wed, 08 Apr 2026
 03:06:18 -0700 (PDT)
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
References: <20260226055521.1655243-1-pkleequanta@gmail.com>
 <20260226055521.1655243-3-pkleequanta@gmail.com> <258747f4-9da5-44da-8eb9-24f8a8cbff3a@lunn.ch>
 <CAK8yEODCyYxkggU+7=xzWFcXP6RMTpNbHyYRHZhahX7=b6reqA@mail.gmail.com> <435616b8-8d4c-4814-8f21-d667755473f1@lunn.ch>
In-Reply-To: <435616b8-8d4c-4814-8f21-d667755473f1@lunn.ch>
From: "P.K. Lee" <pkleequanta@gmail.com>
Date: Wed, 8 Apr 2026 18:06:07 +0800
X-Gm-Features: AQROBzCq50vj9APjUGuuVNzjUTGEAXBg2-1gD7Ml450ww7_QTh7MwqGYJLjBzS8
Message-ID: <CAK8yEOAYC0iApNHBApt+xu1Fz=+N1wX0XrLGOPzmeRq=OjWnhg@mail.gmail.com>
Subject: Re: [PATCH v12 2/2] arm: dts: aspeed: ventura: add Meta Ventura BMC
To: Andrew Lunn <andrew@lunn.ch>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	joel@jms.id.au, andrew@codeconstruct.com.au, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Jason-Hsu@quantatw.com, p.k.lee@quantatw.com
Content-Type: text/plain; charset="UTF-8"

> > > > +&mac3 {
> > > > +     status = "okay";
> > > > +     phy-mode = "rmii";
> > > > +     pinctrl-names = "default";
> > > > +     pinctrl-0 = <&pinctrl_rmii4_default>;
> > > > +     fixed-link {
> > > > +             speed = <100>;
> > > > +             full-duplex;
> > > > +     };
> > >
> > > What is on the other end of this fixed link?
> >
> > The other end of this fixed link is the CPU port of a Marvell 88E6393X
> > switch. We are using this switch in unmanaged mode rather than using
> > the DSA subsystem. Therefore, we use a fixed-link to force the mac3 to
> > 100Mbps full-duplex RMII to match the CPU port configuration.
>
> You are mixing up terms. The 88E6393X does not have a dedicated port
> for connecting to the host CPU. Any port can be connected to the host,
> using DSA tags. And all the ports are 1G or faster, so it seems odd to
> limit it to 100Mbps. There is something consider a CPU port, but that
> connects the internal Z80 CPU to the switch fabric.
>

I apologize for the confusing terminology. I meant the port 0 of the
88E6393X is connected to the AST2600 mac3. Regarding the 100Mbps RMII
limitation, this is a strict hardware design constraint on our
specific board.

> > > > +};
> > > > +
> > > > +&mdio0 {
> > > > +     status = "okay";
> > > > +};
> > >
> > > If there are no devices on the bus, why enable it?
> >
> > We intentionally enable it so user-space tools can access the switch
> > registers. I have added a comment in v13 to clarify this.
>
> Why would user space want to access the switch registers for an
> unmanaged switch? It sounds like you are using Marvells SDK in
> userspace to manage the switch, rather than using DSA.
>

We do have a custom user-space daemon that configures the switch
registers for our specific use case. Should I remove the &mdio0 node
if it is only enabled and has no other configuration in the upstream
device tree?

P.K. Lee


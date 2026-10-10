Return-Path: <linux-aspeed+bounces-5168-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A76CA6017
	for <linux-aspeed@archiver.kernel.org>; Sat, 10 Oct 2026 08:11:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j1xJW57KTz30DH;
	Sat, 10 Oct 2026 19:11:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::632" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791619883;
	cv=pass; b=ZF3R7G0l3YNSOaFifRlP7jfeoNGtH2tLZZf505cA8ZQ/Rm4XpldYIQpAMRBMXFnbrpmqa24Va+rlT2uW7rYQGVDRvoZHMKI4vUSUBl+8VVtjg84toLCCNjF8Z9hk4KsrLloae6XgEHzeUGCabOI3QGcOkC35CoV4CXUp//8ElbN28HDzLs7MJsV+SfB5bPhXN0A3uZ1UEXMUaYzKVn7sxnmyhgRdMQED9vyioSI9mvhPtPcMDJoNDNJTUq0of1vFqkIvwADqRSaRVLZIWk5Pu6kpVHHJSdKERqpR4jmjJRJsTZHCH3QPvG0xZjCjdNy4Lc4JACFMkyaLwAtOyB7hzg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791619883; c=relaxed/relaxed;
	bh=3Y/fF6+yWSNp7n7WrJyW9ic7hhZX15xNpxqUx5k4mho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VyhR9gCjkPmemvrzU4l+lb/jwsif9Nl41VVTQkhp/W3WblFNpQIKdLehSKIB0J2HGjlzFKkexxwdHmL3puhLyt8JNv0fo4nXBNn8JK5u9Q0hn3Qc4NmtQNwoR3952JV50MITRIhjjucgQgL7qd+odUL+vMkkfybqX3hoaabkQN6moP/nnpRbcYyJAz2LjCwteGEM241TtluhCmNRWRvx2OR6eAG8H8pFjOyWXcMiY3BQqNWy8RmfDEh9oMMvjUfLxzsSsFx9HfIU8hyM0zfW3J7V9UXTTJ1bJhp8nt0YqXIIbeQ+02GElAzocxmzIkv8bn1pyFGUakwV9nBmP3Dp0A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B/OKhOal; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com; envelope-from=andy.shevchenko@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B/OKhOal;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com; envelope-from=andy.shevchenko@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1xJT2FLVz2y32
	for <linux-aspeed@lists.ozlabs.org>; Sat, 10 Oct 2026 19:11:20 +1100 (AEDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-c2afa22e1dcso87549666b.1
        for <linux-aspeed@lists.ozlabs.org>; Sat, 10 Oct 2026 01:11:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791619878; cv=none;
        d=google.com; s=arc-20260327;
        b=AefQspNb3fvAf8WQqGSskOLawTpALktjPeHTnqJaeP3Q5eayc++M1N9FIOcvBfuRDJ
         ZFNumChN0ygh5qmpt9MP04MDmDYHdbbaf5tKa6yzbPN0M5K0UIY5AXo/9f87G3JNqBKV
         sXelWVTRenGfmmMt3d/+hnhxECcGYENSJERSeo/xDvgvg4xn38ZJIYwHwxbu+etAWCuy
         bUv5quQcTeqDH6xRcjA9e00I4wCu+KG0cBh4YBFMoWN/xON+HKvh30aLkPGRY6K2oxeU
         4Y2Iri0LwrI9tWDwVwQW3clF+gxXq030VtfiZ9FNbNcp9qna4lbxoGGdoWi5VwO7OOjh
         1OrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3Y/fF6+yWSNp7n7WrJyW9ic7hhZX15xNpxqUx5k4mho=;
        fh=6jyKUjcfiaqmrwB2qrkYMroWRsTdE4HVM506O+jFp/M=;
        b=YbYhreu5LazCOhWGZcfJrQmWfygnVCea9kMWcOHz7LGjDE7MpysiKvoPT2Fd1vd4I5
         mCHdv24XFTe1a5EjEGYE83A70gMQJ3awSmLYBNvVU1880sztahbmdT5XujoWHOD+sPBk
         oLOEjuiPqO6sIUVVkFFfL4wQe9RZqAwal/EfsMp1gZg23007/zsRgUDmXRuQTw8DdN2c
         yZywYcKYiPAuHbXmZ1GBCc+0gthpXWxU64z1eykL67rPgoF2wM/uZyMeNF0uL4TGHoje
         o3HMLif7Hh4jHnMLK6k3fuDysKTVI4a6sFULpEBjvV4oHGqCoqMWelNHfu9VK/IGTZOP
         bKHg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791619878; x=1792224678; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3Y/fF6+yWSNp7n7WrJyW9ic7hhZX15xNpxqUx5k4mho=;
        b=B/OKhOal8UDul/yLkSc9oXhL/icJWuypVIO8RggCReBPcdxOh98LrjkdgabI1btp0C
         mbL/ULnn90sxCqYFLvUGM2dq+cHwoJd6mdDbsjJuP7j9im561yVogTPwYkNftzWZZJzZ
         izdAhnW3opuZtMsU/yBR8iACgf6taVyry+OmPQfK3GIXhD6hP/UamPHDE47c3NuOVifR
         G03Q/RGmudTmPDOzlW/Tkc0oyyNT9YOzyqumz6H8WPp3REvtbPGGm45HfXroM6I3CJyB
         +i70EB4wc+nsLOkeAAQgFb5uRAgoswpBhLwo/l0FRKqTr+ecagJr2L5Fc3/gIJAzUjuW
         7zSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791619878; x=1792224678;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3Y/fF6+yWSNp7n7WrJyW9ic7hhZX15xNpxqUx5k4mho=;
        b=Kgs+xYewKiTamwUk5zqBcCqBxexhjGftV39o4bYxx81J35IGcsL9jrA8dQE7rNwULp
         plwGmIPpdHOQlfVh43rkxsYB0hC0Ui2Huzqdp2FbvN1jnzB6Hc+JDNu0SvtJULN/J75v
         YlURHnVBEDb1usiNiPUoU2QjbKLsE8Fdwvrj9dh+kMM92y88AIz+AhNPqCoWyBAHJbOk
         5HKpdl3xNs9I3Wz+y5PkLfLsEcUq0ZdToO6ueFibXHUfJMGHHmiINRpM/uuVDK9BJfBa
         Pczx4Xlrzmh4BxLQiS9yt7wxvFbI/jJYmZqJ9kUPc/JhZH6GbGwY0BYQsIRRaw4BwLCg
         2PYQ==
X-Forwarded-Encrypted: i=1; AKwUvBxdvB2rQlga5LUqftGaSqF1yJhXB7et4ncYntOwrLK3RCV8Yrmp2XgVkFLSnwUgbCWoB20OJV+i99kRN+o=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKWLFe5w1Y2AC/iFPYXJS7LJxVQlOCPsGzNGgH+uqwAujTvrOkb
	Uw/VtoK9oCRzRgHUGr/ORBa+yIJWr7MFIY77piDMPm2KbcIs1815CyC1YuHHFpIUCg3iYgBMS30
	NlmkU/mTOexQmbOedplUZgXKZycaL2MM=
X-Gm-Gg: AYBFou2ym7trMezktBM54vLRUc0NeNRA8y+8ZM7qvZo191S5BOZyOrEB1105+AiutJc
	3L37Ol1ayRT/jB4jXljfNhzWqpDDJXDnafRTptoa9Z7eh1ME+m3n3z7K6Zh6XCGxzHLJtYwLX8T
	QLFpOWK/NVkgdNWxYyORF/ZEYiNzNT+QhhifujZIMsV/NEnDRuQMOtsFJfOXAgoF32MOatJvWMF
	Vc39RaK5Fl2BDE9EX+DRnr8S5mLwrC+/jWU0QMU3PmxvWtJX2ZZNue21gXwT3VJfqMNGnxi2kck
	IGnldSg9DNgeMjUKyjHQQNWBXkoLU0M0ef5AxgRWL4Du2QWetp6mLSmpxE39dWvNZWs6eA3PO5n
	f+tgHekVcwpyV1MBTIXG0V0d33LrhwXxTxdWsgNs+4GlNc/f66QI2m2cSg7R/57BOw7EOUaSB2g
	gCIJLohXDgwtP5EIQWAmXMC7Fuqp+B5QrtxTWnF6Q=
X-Received: by 2002:a17:907:d0b:b0:c2a:f439:f028 with SMTP id
 a640c23a62f3a-c31aa062933mr436250066b.24.1791619877631; Sat, 10 Oct 2026
 01:11:17 -0700 (PDT)
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
References: <20261008-aspeed-vuart-v1-1-d2be17c99cd7@phil.gs>
 <CAHp75VdiO9tPX2vLqsX2-omNvs-YjkWWD-HOiqyDSzpJrrZ_5w@mail.gmail.com> <60996F21-A12C-4FCC-9D5E-9D188A4ADBEA@phil.gs>
In-Reply-To: <60996F21-A12C-4FCC-9D5E-9D188A4ADBEA@phil.gs>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 10 Oct 2026 11:10:41 +0300
X-Gm-Features: AclHuK-dIO95E4MKMHhfgONiaVmppwEdlr0lng2Exqtg0ehIlNhsjdfo0t3-x7w
Message-ID: <CAHp75VdmMwXRQFKLG8c4yAsVA5=eFZA3jagtMGb-qVswcQ88Wg@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250_pci: Add support for ASPEED BMC VUARTs over PCIe
To: Phil Rosenthal <phil@phil.gs>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Corey Minyard <corey@minyard.net>, 
	"openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, 
	Andy Shevchenko <andy@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>, 
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, Ninad Palsule <ninad@linux.ibm.com>, 
	Andrew Lunn <andrew@lunn.ch>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 4:45=E2=80=AFPM Phil Rosenthal <phil@phil.gs> wrote:
> > On Oct 9, 2026, at 4:57=E2=80=AFAM, Andy Shevchenko <andy.shevchenko@gm=
ail.com> wrote:
> >
> > There is already a driver for this 8250_aspeed_vuart.c. Please, do not
> > add new quirks to 8250_pci.c.
>
> Thanks for the review.
>
> As far as I can tell, 8250_aspeed_vuart.c drives the other end of the
> VUART. It is an OF platform driver (aspeed,ast2400-vuart and
> aspeed,ast2500-vuart) for Linux running on the BMC itself: it depends on
> ARCH_ASPEED, has no PCI ID table, and programs the BMC-side GCRA/GCRB
> registers (VUART enable, host SIRQ routing), which the host cannot
> reach.
>
> This patch is for the host side. There the VUART appears as 16550
> registers in BAR1 of the BMC's PCIe function (1a03:2402), and nothing
> binds that function today,

In the comments to the patch you told that ipmi_si matches it.

> so SOL goes quiet once Linux starts. I don't
> see a way to reuse 8250_aspeed_vuart.c for it, but please correct me if
> I'm missing something.
>
> Understood about 8250_pci.c. Would a separate driver be acceptable,
> e.g. drivers/tty/serial/8250/8250_aspeed_pci.c using 8250_pcilib, along
> the lines of 8250_pericom.c? It would do the same as this patch: find
> the VUARTs the BMC has enabled in BAR1 and register them as polled
> ports. If that works for you, I'll send it as v2.

What has Pericom to do with all this?

...

I will look into this deeper when I return from the LPC 2026 trip, but
what you are doing sounds really wrong.

--=20
With Best Regards,
Andy Shevchenko


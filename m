Return-Path: <linux-aspeed+bounces-4220-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6093BCD8CB2
	for <linux-aspeed@archiver.kernel.org>; Wed, 10 Jun 2026 13:11:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gb5kk0Rlfz2ykX;
	Wed, 10 Jun 2026 23:11:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::a2c" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781093032;
	cv=pass; b=eWalTGCH2Ts+1AyBdnznaDTEaYl88tNah4mQ8b2tlLDovxWkN4cy6f3TVIpIrvaGgczCStnSNvkqLTePu3aJbkZFBTl42oxZlM7BNVF+e2oYhpYG5MHTyGK4b18fMckdOv2D946OWc9M49sYjnkG8Hd0qZZNTKqkk5/ikaS+rT7Q0EZ2u5TjydGyfET24DvoK9Amw6J762QYBy1KE1/SgskOwlV3DVhWzwoMtcg0SxZlWGlDShXQG/Wk5WxG7hha+MhGDUYF1C/AigmGTckjtaTxQKkcG2KfqPuUWrg5ZKpDTXtUEvT1wE6ga+jd2CVYoTsZ77LJ1ZKmuDWwyjlIyw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781093032; c=relaxed/relaxed;
	bh=yNmA6qhDqA00JpZDpDsCydpEuIe+8jtS64/q8z0mHkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q0W4h2grvoPV0MwyLHmgTAPdrn4PHlrz17SkL4WiBfW7SMyBlQRxwDDRvq3FZTdJq54YV0IUFais29wko52P06DySLxCVPp9B4JvNhuuim4nbqej8qcRjik2k5LNPFj0ArQ9CiIWSVNaopvPx50o4eDqO+yb50w4i7XpdeVG/Yv8zSC4EzXuKOvFChKQdwVP2ttaVdFTdR61HxhCpKXq2vgGFBeuim+1hTPJkBD9B9YGTLdlbuw+98qc7pcrHr7Euk4hu7YV8gx5QVMzmu/ZY+CQzL8RSfZJcL9apptkAMcYpuay59sR2IhL8KFkcRKTMWwFrgQqf2zFRoxNLkGBKQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YIE2Z0qD; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::a2c; helo=mail-vk1-xa2c.google.com; envelope-from=ruoyuw560@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YIE2Z0qD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::a2c; helo=mail-vk1-xa2c.google.com; envelope-from=ruoyuw560@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gb4F262m9z2xYg
	for <linux-aspeed@lists.ozlabs.org>; Wed, 10 Jun 2026 22:03:50 +1000 (AEST)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-59f8a140a51so4007702e0c.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 10 Jun 2026 05:03:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781093027; cv=none;
        d=google.com; s=arc-20240605;
        b=RmWYkBdwklYa4XuDihy+XqNmj6w42EfgBeVidJ5YFjU2aTP1CHxSHeudOOV99z7ZQN
         cMinu0XtoILd/Gh/UGH1vh4YdixcfUc+4NBZT9ow9BoI6H+j20d/lFVQXWxw+aTgj5n9
         uYFkrtaAVdEuoS89Hw2gwjct5EBeiuj+0ObQY11SblcLAFX6c0z4Ypqa8qzeAd7xC8Dr
         GOYM5Dwh1M7rlcPckFSJH5qBuku0eQjiOv0mHcf/xsOAliLtm4U85A9YkKLzNvOjclxr
         Ywvut17AYd0U3KpgrD4xWPQuh8LYo/cydv44cp+hgNn9Yldq9ajUwFsE1XNdLjH2JHuw
         fyCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yNmA6qhDqA00JpZDpDsCydpEuIe+8jtS64/q8z0mHkM=;
        fh=qNC5LbTBvUR7UnSI5dP6JQ9XFKucVeo5EbfPZGk3V7w=;
        b=NdpYx/uyIGYRSqAKKIFt8AU4jE9P3pHvX//XCeQ3BibMmIK7f5lfEbbaz20WzmqU4M
         7y5+nh3UQpo1uHW2Qne9zdPRAjP/pq8l9Jq63jp2RkfJ08j6FxsPj1waZlBz0CHen2wE
         aXlf3B2G0TBOK9wDMAn1poOAooFWRMOBIHngi2PdF4Cq58Me1+GD0e3ZT7GrOuUEa4h1
         UqOh4yyeSBSLw/SycCO3Yz6fqHZT0chFjDM0DmCQFLthPZFgjv6Xd4VeSkA5OZBA7vz2
         IdYOniPtojm2zRfIRhe+s5rGMJsn3RghvjoiE8sET+H2MIvy6Z2p/YdwlB3SB+xOB3ON
         UtyA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781093027; x=1781697827; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yNmA6qhDqA00JpZDpDsCydpEuIe+8jtS64/q8z0mHkM=;
        b=YIE2Z0qD933vAFp0KbMn63Hqan7dSkhUcj9P8n+4eExn58QthyxMJOlHlKUrT1uQZt
         hD8p2WQ0VwHitaPqZH7ZYnW6Qutd+dr2eHgiZ5YCgufExPftvENXmXmHWOABBSW38S6j
         jU5hR2kBZsiZXzrwLh6+lHX4IJYYwO7Tm5rSOKs771XmSU5iUUllYbg/TU5Zq1kM49aD
         Xndq4QW1lZv2MAOYiJoHixmOsM0Y3R3ak4a+XQJlfhEuQ4uWcXMEZ4agOJ56BssElAok
         3v1Jkd1ExkpqSpg5WgnMG/SsQYv/x1yxaNTEwk9xgFNF2gwi2d1ccUCv1ATeoaQgeWPS
         pPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781093027; x=1781697827;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNmA6qhDqA00JpZDpDsCydpEuIe+8jtS64/q8z0mHkM=;
        b=mR40iA6c1SsoLf+vCzDIfLYEaNt6I7S9cO04I3dbNFFjXFxQAn1toq/ba6Dps0otAE
         DbO0H0bCcaDZ5Dq2W1RIcdAqCBS8/BH86DAJHwDlakg9+O/tvDST0oxjlRfhP/1DRTMe
         Miuwsb7XEFFKuwfa5q8KAJHioOI4qniQRh4DJ2L+Sh/iGHp79oiMrqtg3xmIACoCO3QZ
         sbVrS8q/njRPBP2hO9HfpWB9ha+8XpoJ5FoNan6CnkD3zQEg2Ku36mtN1luLzsFxuLQ/
         nrKJT73YNsqyRZcwW5qbCJmgCcRxo81X2M1wfznTAnuS57trz+9wAih1ezW2L3va5RQh
         ICpg==
X-Forwarded-Encrypted: i=1; AFNElJ8MrEKjKVSvW4QBt64CDGf55Yi6y6CGJbXu/PAZ9y67/89zbDYC97h4PD+i/2LE1bdMB3OhlhG7kU2bpmo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwplQgcIZNC7muYoTFJONNG2SQ966gh5L5+L/Q3VeP0RG5m5h2d
	1zmbPiKNCxTzvolwfuMUxNZdwy/LXQnKMPrPiyBdU4hjW+SzInG7ITCQtLfVt4vaGZKpKxBU8VO
	fVq5/DLYQwR7JpMwXHixuNLOOA62uTlY=
X-Gm-Gg: Acq92OGe4GrrePaMPTPmQjgl/v6bwd9LfaEoeUIZ4ETm37U101WqCQOUFVwlV4e02Le
	f/izrly39HKQfakoLrDIAZOO9cSs0biK198AsjPrSzT4p1ZgYT6x4REUQQ00g+HG8btk86Y0uMq
	pSa3yZVbvjlT/46WHT5jwzlbWMZPReZRbJuWcPt+MhHiKtObJpjBX0s0Wy3auA1fVJGbTlLxmCW
	JbK4tEXoPeY9UOIbgBQ0y/F93VVjD4sueBBdgepuVEKwBb9XzEXhbAhccllHUU+LuIFuugDD4r1
	ukZS2Mv5i7LSc0RmqKQfIA==
X-Received: by 2002:a05:6122:46a8:b0:5ab:2fb:2dfb with SMTP id
 71dfb90a1353d-5ac4ec93c03mr12903562e0c.8.1781093027265; Wed, 10 Jun 2026
 05:03:47 -0700 (PDT)
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
References: <20260608081948.3-1-ruoyuw560@gmail.com> <9f2caf9887177bad39525a6713325c252ad47dcb.camel@codeconstruct.com.au>
In-Reply-To: <9f2caf9887177bad39525a6713325c252ad47dcb.camel@codeconstruct.com.au>
From: Ruoyu Wang <ruoyuw560@gmail.com>
Date: Wed, 10 Jun 2026 20:03:35 +0800
X-Gm-Features: AVVi8CcLqV596fcx1mhsXkN0bBUEkSGmmsDnnvGGRDPDQedVtz1aaxhnOdAEKno
Message-ID: <CAK_7xqwTiDjFMLh3LbKij-7yRVBaXy5Tr9DOBQwBndoGZj=O4g@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: aspeed_udc: check endpoint DMA allocation
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Neal Liu <neal_liu@aspeedtech.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joel Stanley <joel@jms.id.au>, 
	linux-aspeed@lists.ozlabs.org, linux-usb@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="00000000000033c4420653e509fe"

--00000000000033c4420653e509fe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks! I will simplify the error path and let err_cleanup fall
through to err.

On Wed, Jun 10, 2026 at 7:45=E2=80=AFPM Andrew Jeffery <andrew@codeconstruc=
t.com.au>
wrote:

> On Mon, 2026-06-08 at 16:19 +0800, Ruoyu Wang wrote:
> > ast_udc_probe() allocates a coherent DMA buffer used as the backing sto=
re
> > for endpoint buffers. ast_udc_init_ep() derives per-endpoint buffer
> > pointers from udc->ep0_buf, so a failed allocation is dereferenced duri=
ng
> > probe.
> >
> > Check the allocation before endpoint setup. The existing probe error pa=
th
> > called ast_udc_remove(), which unregisters the gadget unconditionally a=
nd
> > is not safe before usb_add_gadget_udc() succeeds. Add a local cleanup
> > helper for probe failures so pre-registration failures only unwind the
> > resources that were actually initialized.
> >
> > This was found by a local static analysis checker for unchecked allocat=
or
> > returns while scanning Linux 6.16. The change was checked by applying i=
t
> > to current mainline and by running checkpatch. I do not have access to
> > Aspeed UDC hardware, so no runtime testing was performed.
> >
> > Fixes: 055276c13205 ("usb: gadget: add Aspeed ast2600 udc driver")
> > Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
> > ---
> > Note: a 2022 patch attempted to add only a NULL check for this
> > allocation:
> > https://lore.kernel.org/all/20221213025120.23149-1-jiasheng@iscas.ac.cn=
/
> >
> > This version also fixes the probe unwind path so the clock is disabled
> > on allocation failure and usb_del_gadget_udc() is not called before the
> > gadget has been registered.
> >
> > diff --git a/drivers/usb/gadget/udc/aspeed_udc.c
> b/drivers/usb/gadget/udc/aspeed_udc.c
> > index 7fc6696b7..809a7d5b7 100644
> > --- a/drivers/usb/gadget/udc/aspeed_udc.c
> > +++ b/drivers/usb/gadget/udc/aspeed_udc.c
> > @@ -1434,11 +1434,34 @@ static void ast_udc_init_hw(struct ast_udc_dev
> *udc)
> >       ast_udc_write(udc, 0, AST_UDC_EP0_CTRL);
> >  }
> >
> > +static void ast_udc_cleanup(struct platform_device *pdev)
> > +{
> > +     struct ast_udc_dev *udc =3D platform_get_drvdata(pdev);
> > +     unsigned long flags;
> > +     u32 ctrl;
> > +
> > +     spin_lock_irqsave(&udc->lock, flags);
> > +
> > +     /* Disable upstream port connection */
> > +     ctrl =3D ast_udc_read(udc, AST_UDC_FUNC_CTRL) & ~USB_UPSTREAM_EN;
> > +     ast_udc_write(udc, ctrl, AST_UDC_FUNC_CTRL);
> > +
> > +     clk_disable_unprepare(udc->clk);
> > +
> > +     spin_unlock_irqrestore(&udc->lock, flags);
> > +
> > +     if (udc->ep0_buf)
> > +             dma_free_coherent(&pdev->dev,
> > +                               AST_UDC_EP_DMA_SIZE *
> AST_UDC_NUM_ENDPOINTS,
> > +                               udc->ep0_buf,
> > +                               udc->ep0_buf_dma);
> > +
> > +     udc->ep0_buf =3D NULL;
> > +}
> > +
> >  static void ast_udc_remove(struct platform_device *pdev)
> >  {
> >       struct ast_udc_dev *udc =3D platform_get_drvdata(pdev);
> > -     unsigned long flags;
> > -     u32 ctrl;
> >
> >       usb_del_gadget_udc(&udc->gadget);
> >       if (udc->driver) {
> > @@ -1453,23 +1476,7 @@ static void ast_udc_remove(struct platform_devic=
e
> *pdev)
> >               return;
> >       }
> >
> > -     spin_lock_irqsave(&udc->lock, flags);
> > -
> > -     /* Disable upstream port connection */
> > -     ctrl =3D ast_udc_read(udc, AST_UDC_FUNC_CTRL) & ~USB_UPSTREAM_EN;
> > -     ast_udc_write(udc, ctrl, AST_UDC_FUNC_CTRL);
> > -
> > -     clk_disable_unprepare(udc->clk);
> > -
> > -     spin_unlock_irqrestore(&udc->lock, flags);
> > -
> > -     if (udc->ep0_buf)
> > -             dma_free_coherent(&pdev->dev,
> > -                               AST_UDC_EP_DMA_SIZE *
> AST_UDC_NUM_ENDPOINTS,
> > -                               udc->ep0_buf,
> > -                               udc->ep0_buf_dma);
> > -
> > -     udc->ep0_buf =3D NULL;
> > +     ast_udc_cleanup(pdev);
> >  }
> >
> >  static int ast_udc_probe(struct platform_device *pdev)
> > @@ -1523,6 +1530,10 @@ static int ast_udc_probe(struct platform_device
> *pdev)
> >                                         AST_UDC_EP_DMA_SIZE *
> >                                         AST_UDC_NUM_ENDPOINTS,
> >                                         &udc->ep0_buf_dma, GFP_KERNEL);
> > +     if (!udc->ep0_buf) {
> > +             rc =3D -ENOMEM;
> > +             goto err_disable_clk;
> > +     }
> >
> >       udc->gadget.speed =3D USB_SPEED_UNKNOWN;
> >       udc->gadget.max_speed =3D USB_SPEED_HIGH;
> > @@ -1553,20 +1564,20 @@ static int ast_udc_probe(struct platform_device
> *pdev)
> >       udc->irq =3D platform_get_irq(pdev, 0);
> >       if (udc->irq < 0) {
> >               rc =3D udc->irq;
> > -             goto err;
> > +             goto err_cleanup;
> >       }
> >
> >       rc =3D devm_request_irq(&pdev->dev, udc->irq, ast_udc_isr, 0,
> >                             KBUILD_MODNAME, udc);
> >       if (rc) {
> >               dev_err(&pdev->dev, "Failed to request interrupt\n");
> > -             goto err;
> > +             goto err_cleanup;
> >       }
> >
> >       rc =3D usb_add_gadget_udc(&pdev->dev, &udc->gadget);
> >       if (rc) {
> >               dev_err(&pdev->dev, "Failed to add gadget udc\n");
> > -             goto err;
> > +             goto err_cleanup;
> >       }
> >
> >       dev_info(&pdev->dev, "Initialized udc in USB%s mode\n",
> > @@ -1574,9 +1585,14 @@ static int ast_udc_probe(struct platform_device
> *pdev)
> >
> >       return 0;
> >
> > +err_disable_clk:
> > +     clk_disable_unprepare(udc->clk);
> > +     goto err;
> > +err_cleanup:
> > +     ast_udc_cleanup(pdev);
> > +     goto err;
> >  err:
>
> That last goto is unnecessary.
>
> However, I find it unsettling that in a patch fixing resource handling
> we add a mildly convoluted cleanup path, with portions jumping over
> each other in this way.
>
> The err_disable_clk label is only used once, and itself jumps down to
> the err label. This is the case because beyond its goto we free udc-
> >ep0_buf in ast_udc_cleanup(). I think it would make more sense to move
> the call to clk_disable_unprepare() into the conditional body of the
> allocation failure test, then change its goto label to 'err'. That way
> the above hunk becomes:
>
>    +err_cleanup:
>    +    ast_udc_cleanup(pdev);
>     err:
>         ...
>
> Which seems a bit more natural.
>
> Andrew
>
> >       dev_err(&pdev->dev, "Failed to udc probe, rc:0x%x\n", rc);
> > -     ast_udc_remove(pdev);
> >
> >       return rc;
> >  }
>

--00000000000033c4420653e509fe
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks! I will simplify the error path and let err_cleanup=
 fall <br>through to err.</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Wed, Jun 10, 2026 at 7:45=E2=80=AFPM Andrew Jef=
fery &lt;<a href=3D"mailto:andrew@codeconstruct.com.au" target=3D"_blank">a=
ndrew@codeconstruct.com.au</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">On Mon, 2026-06-08 at 16:19 +0800, Ruoyu Wang wro=
te:<br>
&gt; ast_udc_probe() allocates a coherent DMA buffer used as the backing st=
ore<br>
&gt; for endpoint buffers. ast_udc_init_ep() derives per-endpoint buffer<br=
>
&gt; pointers from udc-&gt;ep0_buf, so a failed allocation is dereferenced =
during<br>
&gt; probe.<br>
&gt; <br>
&gt; Check the allocation before endpoint setup. The existing probe error p=
ath<br>
&gt; called ast_udc_remove(), which unregisters the gadget unconditionally =
and<br>
&gt; is not safe before usb_add_gadget_udc() succeeds. Add a local cleanup<=
br>
&gt; helper for probe failures so pre-registration failures only unwind the=
<br>
&gt; resources that were actually initialized.<br>
&gt; <br>
&gt; This was found by a local static analysis checker for unchecked alloca=
tor<br>
&gt; returns while scanning Linux 6.16. The change was checked by applying =
it<br>
&gt; to current mainline and by running checkpatch. I do not have access to=
<br>
&gt; Aspeed UDC hardware, so no runtime testing was performed.<br>
&gt; <br>
&gt; Fixes: 055276c13205 (&quot;usb: gadget: add Aspeed ast2600 udc driver&=
quot;)<br>
&gt; Signed-off-by: Ruoyu Wang &lt;<a href=3D"mailto:ruoyuw560@gmail.com" t=
arget=3D"_blank">ruoyuw560@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; Note: a 2022 patch attempted to add only a NULL check for this<br>
&gt; allocation:<br>
&gt; <a href=3D"https://lore.kernel.org/all/20221213025120.23149-1-jiasheng=
@iscas.ac.cn/" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.org=
/all/20221213025120.23149-1-jiasheng@iscas.ac.cn/</a><br>
&gt; <br>
&gt; This version also fixes the probe unwind path so the clock is disabled=
<br>
&gt; on allocation failure and usb_del_gadget_udc() is not called before th=
e<br>
&gt; gadget has been registered.<br>
&gt; <br>
&gt; diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/=
udc/aspeed_udc.c<br>
&gt; index 7fc6696b7..809a7d5b7 100644<br>
&gt; --- a/drivers/usb/gadget/udc/aspeed_udc.c<br>
&gt; +++ b/drivers/usb/gadget/udc/aspeed_udc.c<br>
&gt; @@ -1434,11 +1434,34 @@ static void ast_udc_init_hw(struct ast_udc_dev=
 *udc)<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0ast_udc_write(udc, 0, AST_UDC_EP0_CTRL);<br>
&gt; =C2=A0}<br>
&gt; =C2=A0<br>
&gt; +static void ast_udc_cleanup(struct platform_device *pdev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct ast_udc_dev *udc =3D platform_get_drvdata(=
pdev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned long flags;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 ctrl;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0spin_lock_irqsave(&amp;udc-&gt;lock, flags);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Disable upstream port connection */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ctrl =3D ast_udc_read(udc, AST_UDC_FUNC_CTRL) &am=
p; ~USB_UPSTREAM_EN;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ast_udc_write(udc, ctrl, AST_UDC_FUNC_CTRL);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0clk_disable_unprepare(udc-&gt;clk);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0spin_unlock_irqrestore(&amp;udc-&gt;lock, flags);=
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (udc-&gt;ep0_buf)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dma_free_coherent(&am=
p;pdev-&gt;dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 AST_UDC_EP_DMA_SIZE * AST_UDC_NUM=
_ENDPOINTS,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 udc-&gt;ep0_buf,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 udc-&gt;ep0_buf_dma);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0udc-&gt;ep0_buf =3D NULL;<br>
&gt; +}<br>
&gt; +<br>
&gt; =C2=A0static void ast_udc_remove(struct platform_device *pdev)<br>
&gt; =C2=A0{<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0struct ast_udc_dev *udc =3D platform_get_drv=
data(pdev);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0unsigned long flags;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0u32 ctrl;<br>
&gt; =C2=A0<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0usb_del_gadget_udc(&amp;udc-&gt;gadget);<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0if (udc-&gt;driver) {<br>
&gt; @@ -1453,23 +1476,7 @@ static void ast_udc_remove(struct platform_devi=
ce *pdev)<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0}<br>
&gt; =C2=A0<br>
&gt; -=C2=A0 =C2=A0 =C2=A0spin_lock_irqsave(&amp;udc-&gt;lock, flags);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0/* Disable upstream port connection */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0ctrl =3D ast_udc_read(udc, AST_UDC_FUNC_CTRL) &am=
p; ~USB_UPSTREAM_EN;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0ast_udc_write(udc, ctrl, AST_UDC_FUNC_CTRL);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0clk_disable_unprepare(udc-&gt;clk);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0spin_unlock_irqrestore(&amp;udc-&gt;lock, flags);=
<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (udc-&gt;ep0_buf)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dma_free_coherent(&am=
p;pdev-&gt;dev,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 AST_UDC_EP_DMA_SIZE * AST_UDC_NUM=
_ENDPOINTS,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 udc-&gt;ep0_buf,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 udc-&gt;ep0_buf_dma);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0udc-&gt;ep0_buf =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ast_udc_cleanup(pdev);<br>
&gt; =C2=A0}<br>
&gt; =C2=A0<br>
&gt; =C2=A0static int ast_udc_probe(struct platform_device *pdev)<br>
&gt; @@ -1523,6 +1530,10 @@ static int ast_udc_probe(struct platform_device=
 *pdev)<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0=
 AST_UDC_EP_DMA_SIZE *<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0=
 AST_UDC_NUM_ENDPOINTS,<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0=
 &amp;udc-&gt;ep0_buf_dma, GFP_KERNEL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!udc-&gt;ep0_buf) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D -ENOMEM;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_disable_clk;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; =C2=A0<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0udc-&gt;gadget.speed =3D USB_SPEED_UNKNOWN;<=
br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0udc-&gt;gadget.max_speed =3D USB_SPEED_HIGH;=
<br>
&gt; @@ -1553,20 +1564,20 @@ static int ast_udc_probe(struct platform_devic=
e *pdev)<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0udc-&gt;irq =3D platform_get_irq(pdev, 0);<b=
r>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0if (udc-&gt;irq &lt; 0) {<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D udc-&gt;i=
rq;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_cleanup;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0}<br>
&gt; =C2=A0<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0rc =3D devm_request_irq(&amp;pdev-&gt;dev, u=
dc-&gt;irq, ast_udc_isr, 0,<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 KBUILD_MODNAME, udc);<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0if (rc) {<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;pde=
v-&gt;dev, &quot;Failed to request interrupt\n&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_cleanup;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0}<br>
&gt; =C2=A0<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0rc =3D usb_add_gadget_udc(&amp;pdev-&gt;dev,=
 &amp;udc-&gt;gadget);<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0if (rc) {<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;pde=
v-&gt;dev, &quot;Failed to add gadget udc\n&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_cleanup;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0}<br>
&gt; =C2=A0<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0dev_info(&amp;pdev-&gt;dev, &quot;Initialize=
d udc in USB%s mode\n&quot;,<br>
&gt; @@ -1574,9 +1585,14 @@ static int ast_udc_probe(struct platform_device=
 *pdev)<br>
&gt; =C2=A0<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; =C2=A0<br>
&gt; +err_disable_clk:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0clk_disable_unprepare(udc-&gt;clk);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0goto err;<br>
&gt; +err_cleanup:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ast_udc_cleanup(pdev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0goto err;<br>
&gt; =C2=A0err:<br>
<br>
That last goto is unnecessary.<br>
<br>
However, I find it unsettling that in a patch fixing resource handling<br>
we add a mildly convoluted cleanup path, with portions jumping over<br>
each other in this way.<br>
<br>
The err_disable_clk label is only used once, and itself jumps down to<br>
the err label. This is the case because beyond its goto we free udc-<br>
&gt;ep0_buf in ast_udc_cleanup(). I think it would make more sense to move<=
br>
the call to clk_disable_unprepare() into the conditional body of the<br>
allocation failure test, then change its goto label to &#39;err&#39;. That =
way<br>
the above hunk becomes:<br>
<br>
=C2=A0 =C2=A0+err_cleanup:<br>
=C2=A0 =C2=A0+=C2=A0 =C2=A0 ast_udc_cleanup(pdev);<br>
=C2=A0 =C2=A0 err:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
<br>
Which seems a bit more natural.<br>
<br>
Andrew<br>
<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0dev_err(&amp;pdev-&gt;dev, &quot;Failed to u=
dc probe, rc:0x%x\n&quot;, rc);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0ast_udc_remove(pdev);<br>
&gt; =C2=A0<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0return rc;<br>
&gt; =C2=A0}<br>
</blockquote></div>

--00000000000033c4420653e509fe--


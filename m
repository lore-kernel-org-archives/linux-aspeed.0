Return-Path: <linux-aspeed+bounces-3453-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE33AD172A9
	for <linux-aspeed@archiver.kernel.org>; Sun,  1 Feb 2026 22:41:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f44V758yZz30Lw;
	Mon, 02 Feb 2026 09:41:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::102b" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769762419;
	cv=pass; b=Qkv972EoJ6wAU1oPNhCwrS6dZcGY65MlKyHJ8gqKghkZs7l7eX2bX7+q5iDqUJ49bTwE6qnilpvID5m2/SXillDpM5JBHPfSg8KUrHCDpR9Ka8aHHKXm48PoOw//Yv+L0ns3oiXuz7S4ht/iy8Mw7zQZuW7PeIunBWhbaHvAJ6f0flH4aRGDZe88iyMfuX9cbIjvQACkAMYlPxE2SOer3YmFpHRDBac96vZAkvzKCRTkq61VFGPEccc/puLHsaMt0ZsJi+PVW+acFQvBA1bpFb+vDKflGR+JsV6j8hAmct9hSTpHZzbHuEVthuhYH28zthN8y628kST8e5BwItRCDw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769762419; c=relaxed/relaxed;
	bh=bSzFXN53vplKWS6PnrB53pSwv37woM51TQmZ/gIlzlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UHXFlAD5YNQYLb/Crd0GASMgx3Ot4fOyQYwbAelHGpB3rFfBNzIg5AQ0tAdYhk0yUMh9A7OmGtb9/9/nhmg/z3VRTn5B6dR1mo4MfvvQ9dERzjgowa5zn/Z2bqflVdMA6NlAPSPs5AO8FW9RnhRg4y3tGFtny5ci4Cuw5HQ227szmD6VADtQBJRcgGCHUz9zzzXncSMzeXCKyAeM+lNhdulpZDsrCJv8LPbjifJM87JNXgM259HuJfIbz38+mjO3pTABHk7nN24cMJ4jPYLykbcNEwa/ce68jMDmy3wUUxluuqKW++OrwzeLAaiN/DGIWygqre0Uh2E6jFQiK9+iMQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=B2+s8IUr; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=B2+s8IUr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f2Twd56jYz2xjP
	for <linux-aspeed@lists.ozlabs.org>; Fri, 30 Jan 2026 19:40:16 +1100 (AEDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-34c3259da34so1219016a91.2
        for <linux-aspeed@lists.ozlabs.org>; Fri, 30 Jan 2026 00:40:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769762414; cv=none;
        d=google.com; s=arc-20240605;
        b=agzG50CWB86G2PW8wGtf8YRRLxmozwkVaTi/gLeZEUNmiKH5FPpRI/ub2vlkjVnoaG
         oKiTNPl0LY+N9ok0z4aJcUKFPx70AWkscWUt5lOIRhlue+JvP6+eHG+7ONFkctfW2iMg
         KEGLbD1EaSgRBEM+daMuWvv4p0VaurjbHN4KwmhTi9n/S9tss7FrwMmSNpHOnKQ24txi
         qid2U3z5Araqu1qVDBBhogJbAC9gSFSQTtrylURzxG8SEspO2g1F8H6PMEDMJR4G4qh4
         ngABXtYZPkiLo03BWk1LY7Cprpmc9GhN61A8AvpQSXtfEnYzFiXEraRH1KeaTinXUhYe
         cx/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bSzFXN53vplKWS6PnrB53pSwv37woM51TQmZ/gIlzlU=;
        fh=qxAmSg78Vjpj1wwOO8x8RYRRaO04Qj4wVM257EK20hs=;
        b=WbW+7qrwn0vf/4joLENF5aUwV/d6WLFPLiKmZGikoGlQkBThC2GkBZ0NFmZFFU6xsm
         krHMHZJtVzno0In4CoWKdTzJh5pfz6DXoqB37WezCBNs9ORSEp1XCYOqJd2uG+OQsUIL
         bZpktPysbQrcdlFlKJrm6lA+MkmVt2aW/CHKu4tnA0QzlE1gaDoEN2E0MnajTwUlp0a/
         zIhV7t7cj86cI/+yQHV9k0ZC5xEoBEHOEXeuIxq45ojU097p84sYb3MDAcHgOKedEKGN
         N04ycraUGG5l6XHtboVVDodNBTI3XbgF5m+qvS+2aSRXa21aBF0YeS6GKyqdPlVeCHUH
         kFtQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769762414; x=1770367214; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSzFXN53vplKWS6PnrB53pSwv37woM51TQmZ/gIlzlU=;
        b=B2+s8IUrkzwH8WUQtgUQaRyj1lOLPY8egWvEoElxuBT4cJm3xVJcsmTg6V8EbAmc0Z
         BZSxP4qfaKK1ju6vcA6xuRns7f4gMSj5LqSaYsABH5TVzF/k0MZoj6mHddEtwXp522ZC
         BfPpa3eS9uw3mN/G8N/9YJNDfwyUYRTn45DvLDBDnxU6hL9G/bINAY2pSc/XjsMGQQCU
         qmSzna1AhVco9UVvXeX3UQ9dIMvu5NJcwK3FVEoORKVaziEU4ExDYrodK4HuUKIuewkA
         tOZiMOWlwEL3nrxcrs3WWrR3lwLg1JNefVTmWABsQftKZ0E/Wc4VRdSl3JTIk8FnfEAv
         Jp0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769762414; x=1770367214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bSzFXN53vplKWS6PnrB53pSwv37woM51TQmZ/gIlzlU=;
        b=o+UfekECFl5BWutCsWOhNldHaGgdx25HXGI2vJ+ZGe6VbOwPOUEVqxTSrMy6AJW9E+
         iH2hOTKua/P/gaStTOV39vauQKellhAonwo73RRwv8Lgl/fgaSR+6Layf21bK0e/f0oQ
         3cFpJPxfq+DXJarv885BkrLuZLdQuz/T6BSsHL+tLyxhfGb+pMyvzodOW97gOTEDBuuh
         P0jBLphMqnK4kK2TEYVn9rzBnx+nXuFcWt0Fr9XKFCS+NH5Pq8KlJU0O88RF5C4yZmXU
         rZO0NPVBu0N8xtbZWkizawqeFzlvOHlFmvD3/N8hm84x3KuGObWDMpyt4Cwx8+RbOuru
         XoQA==
X-Forwarded-Encrypted: i=1; AJvYcCXmCiBYnNcZWDcDi9hc9/KkNX0/f1Rd7VZi7EKUtQtnRx6HvrVPdjFnQKPzBXCj+0z29D4I8Bv0Cr3UcRc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz+RbtML8T9vlNth7u2yS7+d2c+7wqS39KgatyHLaVtgLwD4Li2
	1t+xLTBrpXCKn8B/5yUHidWomuK120n6dEzeijXg/UsTapjtyhz2dXjNvUPlvOjeMjmkkMzvkzt
	FT5uJJwn5JVZ5RCVZ9xEFc1rdkwgznYs=
X-Gm-Gg: AZuq6aKdYi97yRAy/fHrM/mT9IVDJ9ATVljWSniba5SqjqxSgqtYT+iCkSbqWh1hVfQ
	Llb7yX33p7DZUP+iKF/SCHNlL7Znnkc4/BvEF1o4SbGrWCEASnL7bkCkL0VXLv4SIE+Q0WNuEUV
	p6FKL+xlz2qBzBnkrEHSZsPuSRkUrmXQd3HrT455Yknr6i8URDSoDqJB6CghGWWFDVAGG4LdDuI
	dhhkrGl3LhKZj1+bfYwmRDIg31sTCJAG9E9mgpGJ/1L4teaSipRq23zQldxyKFuZ+8+OF29
X-Received: by 2002:a17:90b:270d:b0:353:39bd:3ad2 with SMTP id
 98e67ed59e1d1-3543b305623mr1811680a91.5.1769762414422; Fri, 30 Jan 2026
 00:40:14 -0800 (PST)
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
References: <20251222-yv5_add_dvt_e1s_ioexp-v1-1-25ad202d2681@gmail.com> <a0d802a1e450860a9859ce3d456fcce81dde8ba3.camel@codeconstruct.com.au>
In-Reply-To: <a0d802a1e450860a9859ce3d456fcce81dde8ba3.camel@codeconstruct.com.au>
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Date: Fri, 30 Jan 2026 16:40:03 +0800
X-Gm-Features: AZwV_Qh0YugKL7P5Qp4faBa4pFcAFafyTEwBvU80qMkiPLr1D8_zLD6pOGbecE0
Message-ID: <CABh9gBfdNnWVUy2+pdMZWjt+mgKCV3TxZei3V_cPTp1z1fguEw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: yosemite5: add x4 E1.S expansion board
 I2C mux
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Amithash Prasasd <amithash@meta.com>, 
	Kevin Tung <Kevin.Tung@quantatw.com>, Ken Chen <Ken.Chen@quantatw.com>, 
	Leo Yang <Leo-Yang@quantatw.com>, Jackson Liu <Jackson.Liu@quantatw.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 12:46=E2=80=AFPM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> On Mon, 2025-12-22 at 19:25 +0800, Kevin Tung wrote:
> > The new hardware design adds two additional E1.S devices behind an
> > I2C mux at address 0x73 on bus 10. Add support for this mux in the
> > DTS device tree.
>
> Out of curiosity, you're monitoring them with the NVMe-MI basic
> management command and not NVMe-MI over MCTP, or is there something
> else going on which motivates describing empty mux legs?
>
> Andrew

Hi Andrew,

We=E2=80=99re monitoring them using the NVMe-MI basic management commands
directly, which is why the empty mux legs are described.

Kevin


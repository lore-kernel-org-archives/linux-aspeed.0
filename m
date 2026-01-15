Return-Path: <linux-aspeed+bounces-3353-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F11CED4662F
	for <linux-aspeed@archiver.kernel.org>; Thu, 15 Jan 2026 23:12:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsdzN2nmmz2yFh;
	Fri, 16 Jan 2026 10:12:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768451920;
	cv=none; b=KfdPtbF6DjcsirMMWyr6w7SSTL8aLsFbbvsMjqqZkcehAUhIGRF5+dGBjHiVzmOgkyjmK8C+REUDleVYo03v4gJMqfucId16O6S5ekY7nDpxwoE8+rY7DQsA53nXbXJ4WNOE4b4Vv8Fa6a+0rUagINPXiISttA7ya8thxQY9wtD5EXHFGWlHNHcO7SsnelQEL8VoQxAc3dG9QpOBtww1fAiJuPtzS25Do/CC2zhY0QtdqWLo7Ti7NgfLUTDI8cdxw+Mx1QLtNzehZTZ1cqyO/RhT9exKXQH5aRvrlclvJ37gdZeipkLpZ1YbTxip/A1+E0FCAhI0DAF+gh9nEcvdBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768451920; c=relaxed/relaxed;
	bh=K6fjjXfXdXI+f3gfu+7LUUm7YVOdAS+PartG2/fB8Co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fKQyrS0aEZOawHx/QOaJbQXSZcOzKB4YZ/4tFNpI6D7iohLsda7i5+OhoH+aKbe0GQVX3PQ2XzKEPn+K8JD0cDFjF5mPGvfO0VOm8+PTCJ2VIcSuEawn8C8PsPKYXXaTD7zfS9HliLqO5iksZs/4MhsUr1oEwdGBtkwDEe2r9LrCtP2Tr5/ja3gHQhY6CcgTQp4gmm/DGLLs/J6q42a/n/iYXGXsDMVH2qULUo5Ds0N74r2i+og7qvcpY2eRpENL2u0x+9NJxk1Zm2LtWMTjlZ7Sl77k2Jzxsyuf7/1ZOEEMLKo6/3g/NtnBAbCyAXtxTjOxD4i6hZojv6Zx0jWBfw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dWvdFA1k; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122b; helo=mail-dl1-x122b.google.com; envelope-from=anirudhsriniv@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dWvdFA1k;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::122b; helo=mail-dl1-x122b.google.com; envelope-from=anirudhsriniv@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122b.google.com (mail-dl1-x122b.google.com [IPv6:2607:f8b0:4864:20::122b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ds9Gk6n8Gz2xHW
	for <linux-aspeed@lists.ozlabs.org>; Thu, 15 Jan 2026 15:38:37 +1100 (AEDT)
Received: by mail-dl1-x122b.google.com with SMTP id a92af1059eb24-11f3a10dcbbso467929c88.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Jan 2026 20:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768451915; x=1769056715; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6fjjXfXdXI+f3gfu+7LUUm7YVOdAS+PartG2/fB8Co=;
        b=dWvdFA1kHLHgFnzTdKqOkG7k6LBS6nXnIvXchQ5yUsE6mALUlLXWHQiXvIp+9W4zVI
         bUH4B0Roisn5tDM0dwrdhdhX8FiS7sizfqKCqMDhe/gDSQIkWDHFQ/sl/4PlccYtzu9B
         0ps/TH9OqJuXLb94AXnDUZi6R3MX9KwXlOtLYYSbgXoc6Tm9ALTFcST0vOC+nIW7K34P
         Qcbs/4OvngzTvYq/x3ZbIV9ih12Ai7/5gbnaypiDgEf4B6pMHcYnS+OmhvCqkKL55akm
         yFrtw52Zl2JqDyLtimoIMlJHDNxo5YrG3qz+EsHyasZB1LCPw5rPcF3xpKkjVnMqya1t
         Voog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768451915; x=1769056715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K6fjjXfXdXI+f3gfu+7LUUm7YVOdAS+PartG2/fB8Co=;
        b=YxlQM1hOim0pYG5zuEOhV5LUF1TysMujKe3QZTzUDwIZ146uoYgyrKtD0KfWfiEPf3
         vyxxjf7Mmf0ZLrepO/+bi5y9TFkrxvCo8isgIjCALRFZQeebRFl2Ajr9juYlb5+dp49W
         0c77QldU9yPnUpZTlVNcuu67yJcXx1A5nn+L+VT7rQ21rRnDiP1Q9Q3d0jDOnjTglTS7
         n9c77LtTbTay7b5xs6/8FGzfs9Fl4rk8XmC38VwuroD1vvF0STUPQV8BEv+f16Uprv+5
         at1OXrbBV15DBZlrbLfTiQ6inLhhmKFDFDFC6nsR5LU7/GqchyBmdqvp1Z3wr+1nKuEs
         +iDA==
X-Forwarded-Encrypted: i=1; AJvYcCVG7GsTwpPjOwvX3LATB4jd7GKqfpvEdZwpNjPwp8mIZkECGLLEWMf1Gc7iHgpaRIizdn7XSu5ay9FaeQY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzc0qJb+ad37c0NONSRdP7t2TpG04n2gYRegXI8MwHvllPrNdrV
	l3Z2AgsgfF0mQxEKmNg6kG9oQcW0jVdrXQ0KVSVGZgx4Wns/nIQt7dgGe/84eMTKgwQleu3wi0x
	mLUGpXW8XXhx7t4VK6enShVk2LHZgQYQ=
X-Gm-Gg: AY/fxX7oIqUenEe4t1vz84eioEF5k0FFZl+eYgPUMdCzLaZGQn0POpFYe553qWqXy23
	hsSv33jYmGwMk/79HZdau/cY/ElQJTSY7O3Im47jqnd+9Uc45VMuiJHN2IGxV/b4ufvT2L0vooW
	wXKcGoO7ktuZsrSbAW06LajCYVc8Qqvv9/iEr5VhWq+MPeUMGVudlxv0V0aQbprXuQw5Sb0FZ9I
	t3LjePDTc0X//YOu34fNKpPHDU3uOk9Fu8lkfq7zmHTDhAvAhhkG/HjYg5WpUYpOnsPhZJMJlKE
	X2PA2g==
X-Received: by 2002:a05:701b:2714:b0:11b:ceee:a49f with SMTP id
 a92af1059eb24-12336a247cdmr4745181c88.8.1768451914862; Wed, 14 Jan 2026
 20:38:34 -0800 (PST)
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
References: <20260111201040.162880-1-anirudhsriniv@gmail.com>
 <20260111201040.162880-2-anirudhsriniv@gmail.com> <45bdf2a6c0d33dd6ce0fd3cc279ef6edc509a540.camel@codeconstruct.com.au>
 <20260112-whimsical-annoying-fulmar-25e4d9@quoll> <CAJ13v3RKydFK+sP_Cm-HnQjsOJSDyX_dsGs_Yy564V=Wc7tQFw@mail.gmail.com>
 <e97b7a193f8bbfca9ec00037808ad80a5baf9f00.camel@codeconstruct.com.au>
 <CAJ13v3QYWRfyivrbP=+hreHuMkYWGPkngW3kJyq6xNVL6YdpgQ@mail.gmail.com> <0e611132794491eecbcd3426222b6dca09a35b84.camel@codeconstruct.com.au>
In-Reply-To: <0e611132794491eecbcd3426222b6dca09a35b84.camel@codeconstruct.com.au>
From: Anirudh Srinivasan <anirudhsriniv@gmail.com>
Date: Wed, 14 Jan 2026 22:38:22 -0600
X-Gm-Features: AZwV_QiAZ2miykzbN0XeJ-opRxy8zZQtPtnuJhtoFTPjOMJKnrOQBUdwpXszwIE
Message-ID: <CAJ13v3S+u7fi2h1MUQ1QvFm6Ouz4TDrNwJq3fJvDmBf37h8LGQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: aspeed: Add Asus IPMI card
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 7:03=E2=80=AFPM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> KODO is pretty consistent in the firmware update file name. KOMMANDO as
> the product identifier also seems reasonable, even if it only appears
> in FW_DESC in the latest release. KODO -> KOMMANDO seems reasonable.
>
> A brief bit of binwalking suggests it's an AMI MegaRAC implementation,
> and so I expect 'SPX-13' in FW_DESC refers to MegaRAC SP-X[1]. The
> significance of 'TB2' isn't yet unclear to me.

Yup. The screenshot in the PDF you linked looks a lot like the webui
on stock firmware. AMI has sources for a bunch of stuff ( "unmodified"
source tarballs and patches to apply on top of them manually) over
here [1].

>
> I'm not super concerned about the length of "asus,kommando-ipmi-
> expansion-card" - I'd prefer it over incorporating the 'kodo'
> contraction.

Understood.

>
> I guess it's still unclear whether 'kommando' is a (future) line of
> products or refers to the specific AST2600-based design. Perhaps we
> could solve a few problems with 'asus,kommando-ast2600' and including
> the phrase 'IPMI expansion card' in the binding description for
> something searchable.

I will make the compatible "asus,ast2600-kommando-ipmi-card" and have
the model name in the DT contain the phrase "IPMI expansion card" for
searchability. You mention about adding something to the binding
description (that'd end up being more than a one line change to the
bindings) but we could just have the DT model name have that
information.

I'll send out a second version of this series shortly. Thank you for
bearing with me on this. Naming things is hard.

[1] https://github.com/ami-megarac/OSSW-v13/tree/master/Core/

--
Regards
Anirudh Srinivasan


Return-Path: <linux-aspeed+bounces-1755-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C094C83F22
	for <linux-aspeed@archiver.kernel.org>; Sun, 20 Jul 2025 23:36:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4blfzw48Q4z2xgp;
	Mon, 21 Jul 2025 09:36:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::22c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753041080;
	cv=none; b=OlbCfJrlh/xEygEajKop+ehEguFPoNcs9uP1RduBNG/bdxmncUxm6GH9J4KZisAJ3E37xMMqCecjSJd1HGEC5Dg7bd1Qg/j8UryN7jwhz+Wrg+kmbj6GdOxmuv+99spQ5xEjL8ydzrsBtXaDvNYLOqY4m6CcWDsu/wAgHoGIC+AhWDw/WA7M2UX+zbrtGD6t89WEankSdcOYtH2iovpvnp8UC28YKw31Qe8vDV5PwflAPRS7zEuGzC4i+CNUy83NaVmIXnOLvdpCmXG4UyufFB40legpq1vWEl39oog7Bma/KfgmdG5LFuJodgFsv9B3dydBpEjYLnKyW5QkcYoR7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753041080; c=relaxed/relaxed;
	bh=8pdUiGWbsgg0CJ4pLUwtMgPfW72vVxz6DKVN1oZBlnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CLw0/ZMO5jSnZuKA04wtGjFFRpXfZi029pTjcO1m+J1J38yyuLmo1c2aNzrCNxI/GBY1S1JK62KxzEM1Er74hv17IK/a6zw0T31WUCeOM6QDe5cyaXI0zB7A+2CgdqfSX4bn94APRY/H20vz1sPz1pGQWonVlMc/pDoWFRs/kb5RO7qSODy60ftC8ukDA0kPlxbLA3C41AMjscpX/Rl0EzzfGzaPn6tCOhRoBDPx4J7XE8wZrjksM+jI6BS6/S9SLF4UmYfrJC8agb2TNv3xnRHQLtTZWa8ZZ0SpxP0ci5V0bgFdUN2+OvieSSrIX9YNxS3aGaMauHq73jzvIq+LCg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dB8OpqM1; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::22c; helo=mail-oi1-x22c.google.com; envelope-from=jassisinghbrar@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dB8OpqM1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::22c; helo=mail-oi1-x22c.google.com; envelope-from=jassisinghbrar@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4blZ0Q0fv1z305v
	for <linux-aspeed@lists.ozlabs.org>; Mon, 21 Jul 2025 05:51:16 +1000 (AEST)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-41eaf97412eso1972107b6e.3
        for <linux-aspeed@lists.ozlabs.org>; Sun, 20 Jul 2025 12:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753041074; x=1753645874; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pdUiGWbsgg0CJ4pLUwtMgPfW72vVxz6DKVN1oZBlnk=;
        b=dB8OpqM1WkgSBb7X7jJAsok4NSRWqvS66sgdHdCz0ued9tEyHP3/KgtTKLqOrIscYZ
         XzyawvsQ/lEwWh4I6YnXUz4hT2SmzfCmxqeLqUX7t3GF+1u00ggSSt9onOqUHYbOPI57
         BaL/m/22vtsgGOuJoWV4+45boo+kE1K8C9al2XPqtskmVymLrLniYP4XkVwDmfU75iPm
         YJjE8bc0X76yFuVEx+t7oQ4jisPBwv+i7cZqwgDl06bbXav8Di50K93E1Il3QpW/VTiU
         7AfYnfTxdt4znDnr1lqbbNOrJwGsIcN0rpQ15w4tOz7kl0nF897Jz27QASdjwlnmnjO8
         qYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753041074; x=1753645874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8pdUiGWbsgg0CJ4pLUwtMgPfW72vVxz6DKVN1oZBlnk=;
        b=GAVFpxTtDwimsHi5BaN2sQWuWQw8NM2blryhetHkGijWbn++8jS1pYtqMa6A4qvf5n
         QuzqJ5p4+VIpGW7TMHYySjAzBujxMkrHU/eLOpDJSIhM4mUnga02745sys+tjCJm5KmZ
         dWPJ65fK4g7l6q1pFmK8LmSQYEczYumlQ3Q41OGhDMmkzzauOHJ+mzl6a+XU19pprNK7
         cYhLPiGgngzzcS1fCp/jiKQ66sQn5bMcxCcWrblE2JWnmrpIqSieNdfO6Y0dkrd0FGvp
         P2JPOaki5NJoHwGsjm9rcNljqveVQCY1+qtC7cxBuImldbKdKqmRFVDzcdktLVMdKVgv
         wy8w==
X-Forwarded-Encrypted: i=1; AJvYcCVfTP4pbByLcbWSi1SFSh96S8K5trkLjnie17wfxppJpuUbXCsrXymm1MImp5ZHAeOqFqzEhFUIXOFL22Q=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzxDOn+0GGUVf43RSOdBFUMsaukbtWLCapjz3gEeXrSBIbAne+T
	A1HO4YJv1c/A5Dlu5qZy7Yb3hS3ofX2OBSljWt+i/8j02iEnmjZadtgRBGYR6c8BZdWQhLt6Fqh
	z+HdIPkrVQrIborT9yi1i6WcLg4F6Pas=
X-Gm-Gg: ASbGnctnf0GOnUa/DQdJkrJxQ/1K6b0EI7lCNiweYvHLjKhoqCdqctvx+Qr7zNkm1xC
	1T7Mg//SX4fL4vh2ZbHvYtvvyV6BsyHGRZZAo5QxNdCM9gBQC37JQ40lRSGVuOM+e34ystIuyPZ
	YLjUW7JW8yAfHe7bfo3868fRPJwBV+/1HEheUOyScfv0iAE1cfMKZ7+Eq7XM31yUX3gGgI9X99J
	5ErEI3ljw/8oYHjdD4=
X-Google-Smtp-Source: AGHT+IHt9uAWCHbIYGEdJFOU/DaDUPPXZITgD+rBr+XvH6npb6aGodI/kJwOtF692HkZTJVuU0Kx7GBVi3i4oDGR0Dk=
X-Received: by 2002:a05:6808:2226:b0:41b:f2a0:28f7 with SMTP id
 5614622812f47-41d05756050mr10790464b6e.36.1753041073815; Sun, 20 Jul 2025
 12:51:13 -0700 (PDT)
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
References: <20250702011956.47479-1-jammy_huang@aspeedtech.com> <20250702011956.47479-3-jammy_huang@aspeedtech.com>
In-Reply-To: <20250702011956.47479-3-jammy_huang@aspeedtech.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Sun, 20 Jul 2025 14:51:02 -0500
X-Gm-Features: Ac12FXwcwYnjAjxqqsPWb8Z6fZqKu8-qloc1mBHuXxX-CpWSK48rSruJh4ba31s
Message-ID: <CABb+yY1kyZdMqcMRUEdqCYByQE=DurfnejtvuQsMf9wfLiij2g@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] mailbox: aspeed: add mailbox driver for AST27XX
 series SoC
To: Jammy Huang <jammy_huang@aspeedtech.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au, 
	andrew@codeconstruct.com.au, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 8:19=E2=80=AFPM Jammy Huang <jammy_huang@aspeedtech.=
com> wrote:

.....
> +               /* Read the message data */
> +               for (data_reg =3D mb->rx_regs + IPCR_DATA + mb->msg_size =
* n,
> +                    word_data =3D chan->con_priv,
> +                    num_words =3D (mb->msg_size / sizeof(u32));
> +                    num_words;
> +                    num_words--, data_reg +=3D sizeof(u32), word_data++)
> +                       *word_data =3D readl(data_reg);
> +
Please clean this for loop.

Thanks
-Jassi


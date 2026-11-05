Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D22606A31B
	for <linux-aspeed@archiver.kernel.org>; Thu,  5 Nov 2026 22:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XPZFFODh
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLHNn28pMz2yRn;
	Fri, 06 Nov 2026 09:41:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793885290;
	cv=none; b=aWafBNKTP22io7s73p32bYNq/Y/O8ks7XPNb8RmDkwmrD6eMNM7Je9caNGk5Xwwb+3xEXZamy8IN+uqdo5S9sGOJ9tbB7XL5TBSVJJxN/6SzjOwJHuD//AEGlSPqVDMCo5ZnEqwYRpE9N364cwboe9l4DzWGP++/FKBMMiaK9ezWNqsslqsiXdVAmENLESS4mdxQuPOns8JfwreRGJ3nMpjmtKSg4rcuK80ar4YXs6x4V3UWoI4YzNHwhE/RBgrdDgGciJbE46aoZFChE4gUQ3AxqDDZS6EWXKA7pWN3ZO9bU40WKsmKckVhjXePt4ftCFzYD13MXc1g88Ryh//mrw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793885290; c=relaxed/relaxed;
	bh=8ru4HSnwu1oQ4oTSKgIFmon8BQMS/0IiXPCyBWh94vo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JKOa+uOs5I9pFw7raZ9UZ+Tu64Ehhv160iHcQ78DqsDJnDN7fhsR6DPosQJmpJPFPH+xB4/AbLdm3efneyQxMOZz0zge4pdRKFx+ipo8dtb6XyJTMv6X290Iv+VaTPGArGKsr3p7jWTJa8NY+fmwpglgNqXYMDD9UBhde7SzR7/rmDfvmi/WbEiDgtL+HkWRl2u7Foydertld37ijlQ9J2bvQByTQ6IHW/jRKSAMRzDSt26tQTsFULoZ9huzommgVLaYJtJ5tUooctndZYw+LbMxdA0ui9zc72QQecE4ZbPs1ZtLWpmVq+TiHM48s4kjCt0Tv6o9ola0biD1hupX2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XPZFFODh; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XPZFFODh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jL3616Tj0z2x99
	for <linux-aspeed@lists.ozlabs.org>; Fri, 06 Nov 2026 00:28:09 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 48B42421F1
	for <linux-aspeed@lists.ozlabs.org>; Thu,  5 Nov 2026 13:28:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0C01F00A15
	for <linux-aspeed@lists.ozlabs.org>; Thu,  5 Nov 2026 13:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793885287;
	bh=8ru4HSnwu1oQ4oTSKgIFmon8BQMS/0IiXPCyBWh94vo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=XPZFFODhwzMFOPYnFOG/f2gIhmZlzFGR3VM9E9oC8a4Qge/gN/2bdc8JVTBaYSriD
	 dnajOTcdBBJpTxMHp+10l0Hww4xnVZ0fetIDHktnLlpt41TdKtG0jLRinIADCl4h2G
	 H9jkaltZce3g4ycvP2X5mPYMBA1gfAjsP5sGOg2OuR4EM5LCfO+vp/8U7tRacofM34
	 iDJ28HZWn6GSeK6C8KNWCQLlFKH/3v5rxnq3Z53fw/SOOGmAcXpl7LJJaarkym/vD8
	 qRWNwk970yF+LqVNBMWI1q5U5bK09AqlTE7+DQDj2FA3l1W0Orkngo/IVOfFfSff0z
	 AmmNONwv4RLBA==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5ba328513b9so1547394e87.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 05 Nov 2026 05:28:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzLOh0Yv6SaD7ol2AnZnZVUDlv2Wh1C2P4n+PM1plR4XqO9KfE5wDJ81tAslxYWNeK8amv7uAADsfpOWZY=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+Fs4e94G6+G8vt0JItRGxE0tR9lLyAA/DS1a32PmYaddGhlLxk
	tuFcMQv4qbuWTMWdaUjNbXX1jl9xjyL7q/g1o4X8+z/0wXgflMwmcqdbdKNK6Fr9uNCzoj8SPgg
	vDS2V6n4415DiPX3Vq3XSc/NHw8mkWAU=
X-Received: by 2002:a05:6512:68a:b0:5bf:ec95:41f5 with SMTP id
 2adb3069b0e04-5bfec954634mr3564188e87.36.1793885285940; Thu, 05 Nov 2026
 05:28:05 -0800 (PST)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261015035118.9495-1-prasanth.padarthi10@gmail.com>
 <CAD++jLkx4oQ2ZuUSUQE1Qtrk-1XSMdnDjfLG0rrOm=gt9VD3VA@mail.gmail.com> <CAMFFDGhD4K6PN8G+c-hQAL6RG9sVkjo6SXHB5===bYswHh0aTQ@mail.gmail.com>
In-Reply-To: <CAMFFDGhD4K6PN8G+c-hQAL6RG9sVkjo6SXHB5===bYswHh0aTQ@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 5 Nov 2026 14:27:52 +0100
X-Gmail-Original-Message-ID: <CAD++jLkRNSXt+Er3tnnucpAAj=wPa5JFMsdLLixT=8MnGYJoMw@mail.gmail.com>
X-Gm-Features: AclHuK8sEV6qv2B1_vrP6a-7LhjJiL37qYSrwskqM676CSWb53N83wbpRw8_kUI
Message-ID: <CAD++jLkRNSXt+Er3tnnucpAAj=wPa5JFMsdLLixT=8MnGYJoMw@mail.gmail.com>
Subject: Re: [RFC PATCH] pinctrl: aspeed: Handle GPIOZ6 pass-through strap on
 GPIO requests
To: Prasanth <prasanth.padarthi10@gmail.com>
Cc: andrew@codeconstruct.com.au, joel@jms.id.au, brgl@kernel.org, 
	linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 5, 2026 at 4:36=E2=80=AFAM Prasanth <prasanth.padarthi10@gmail.=
com> wrote:

> I will verify the requested base, rebase the October 22 version
> and resend it as RFC v3 for renewed review.

Do you have to still keep it RFC? I normally do not apply
"RFC" patches. Consider dropping the prefix.

Yours,
Linus Walleij


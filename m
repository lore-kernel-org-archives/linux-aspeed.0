Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA51606A32F
	for <linux-aspeed@archiver.kernel.org>; Thu,  5 Nov 2026 09:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FGn3fMAi
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKxb411P5z2xLt;
	Thu, 05 Nov 2026 20:19:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::c33" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793870368;
	cv=pass; b=JdCxBhwdfs405PyLMnE5KhrCHHWnglpq/zhx4IvLtHcfiQoAcjnamAfQbwonjq07nZYEu+5FZWQ3UxM+hqa9HDzWLLOMIHq2fg49tLKIqefwx0vZS5kphSYOraCfh4PxHpFAiFkUcHOo5DvBdr6DmvbpxItoilXCoRQPO23HLXmWuiDNCKoQbUEQuRTq9m7A+vK3S89PvywGyjQe7rxacXdpYyovNyCAKGS/nopqZcJbtzy+MFR7coMWxxwFh0vwMN2iAM+AT6AXFWZDom9gwdUtBB2GjEVWpCcfNZBzLkrNkIUboD1bLsodcYcH8l/TL8VG0H54wDDmC+nSdwUUug==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793870368; c=relaxed/relaxed;
	bh=ndGzkCwTbGT2osVm60AE7H39WPe2NYufaCoY6UTi6Fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=huyY/bkl8y6mjJouJnU07ADsA/YBXZ4LVTx+O1mikm6EYsOnc2B/i1HkutMDLixIyQ+3vArZ7AuEepeyE9FFHr6gZraxMveezZF+yDHxROyGffKN352LWEsSw5uMqlwCqw1bNXL9XFwGMlyuU4RdN/EVwzlaCwLlY7hOQT9bbmjDLTWVZp0+WRZxkq9PA9mNqRynRMubumEhseP6AwFrKAQrJlAIHV8fFa7ZV4Lj9BfspP7tRs1okFkwSMQ+bF+61Zt6kzcgy5XLxdYkhsu5vQCHi4KqFSeP0KMLDvk5g1ZDYynUsroUt5rcFFtFJM6ieh/F/+rHnV5oZ1Q652WtAg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FGn3fMAi; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::c33; helo=mail-oo1-xc33.google.com; envelope-from=chou.cosmo@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FGn3fMAi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::c33; helo=mail-oo1-xc33.google.com; envelope-from=chou.cosmo@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKxb244sKz2xGr
	for <linux-aspeed@lists.ozlabs.org>; Thu, 05 Nov 2026 20:19:25 +1100 (AEDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-6b8e2d8df4fso1110150eaf.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 05 Nov 2026 01:19:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793870361; cv=none;
        d=google.com; s=arc-20260327;
        b=Cfnr5wZBf7NVEJYiSI33sZBRTwtPO1woyM1hj8sbKaZ9zEZU0NxiB1HZbG8xRNPc0j
         Q4Vdff5xTR5tmm71V4QcUInasxvkn7g3bxpieByvRYxmR7dd8kvzhzKZtNW9gnItLJ7B
         czrzPMQ8xdZIY0gmJtZdQY4potnSMoRl8rwUofGkBOr6MqVCuACRnrqWRlbGY5VSBjZa
         eZ6GnhtJUOy9/j6TRxlBZf8wKKcwpHPkRL59dUzivtFG96h2B1SM1iUJBZUvtzWF09l5
         YD129giIJoplDcrR4DFKkVnnhk+6uwNS8y6r2JxZGGdtED4wMQEvjf55PQuUpKSD2S0H
         EcyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ndGzkCwTbGT2osVm60AE7H39WPe2NYufaCoY6UTi6Fo=;
        fh=UaiON6PWSpp0setcEv85WA7Sy0TCFQhg/HbHFF5rZrU=;
        b=iDH5623I/HwiW+eRtBULUfoqmPqweXtdzmMiHx9ICBxOixWqSkxvUMpVrrMcedkU0i
         mAfKg1iQRYXFpsyglocMRp2gViVytk6EUHkhgISnL32Wrqfj3PBbRKijlS599VxqNXSd
         WTbr+qYuf2W3owKQAuQ0xiHgsAPgvgl67oSRhwhoy1Mw6oSVZAeozvh2znbAofygfofd
         TYFm0QC0WQf5AK2sgKT0/qZijembv2Rh6H6yFQYw5mFpYV+5mC6Opmdvjwd0jJNQU6+6
         pmuQ8sxJAMcu53AB0J8Nkcud50az7Hx9Z1ciqh0JVlRUnrZim3ZDe5kj3lacJG8eYBSs
         Tj6g==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793870361; x=1794475161; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ndGzkCwTbGT2osVm60AE7H39WPe2NYufaCoY6UTi6Fo=;
        b=FGn3fMAilehV1LkglB96gThbyMkZK59tmAWwL3WgqWCSwSXyxH0IsYmQGPK7lE7Bsb
         6opSNHAOZ1YsQWHtzz/YRPq9Lh4t4JocgFoJLKJl+O6B/H9usehf7GUas+YeGuAcOO7n
         OYjMQ9C8gpSGpG/VnY5dVvKSBE9ANFEkyWvv2+d5bxCEdEd40xUNrvJrYKeM/dZyJSbu
         xHaQtyaGN/P+2mPlIIZHFRcgqNx+OL7+n7m/5sWsYW9qCggNRqt9G6LJJoafZDQnuB3p
         xn/m3ntUGOMdU3upk//jl3xuK8oAEL7DnV+2Y9juqX5mSDZH4yxj+Wqw6hfLB61kfEZT
         hY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793870361; x=1794475161;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ndGzkCwTbGT2osVm60AE7H39WPe2NYufaCoY6UTi6Fo=;
        b=xjhAnODIkedyOjX6k5QnrQ609Mu6amtf75oPc8hHQjcZFoQSE+vGzmtbB4lk+TYrBl
         bzNakJSO4WZ/whQIS/qWibeQvUAn3a+01KVQxtR/L0dcLx0ArUM6hRW/yrgaNeivkusr
         y0sO07HQ3yZYa02dAX8mHho9H9id3ZbrSnGyH/xBx5LUxO/rK+40bkRXjyohCVUOTHd5
         MqEoTj83Qzt29YmPTkfUjag8Flqg5hQhs3yt9JKlLqoZhINCMVqYidxZL/5i2ceNpKSf
         COfLrJA6Qq/LIvq7+PKLKgjPC7LbSjU8DwvdmFfY/0QXMLCrcJ5h+a5/PSj/0ccBsMpG
         02cA==
X-Forwarded-Encrypted: i=1; AKwUvBzBBwKvVLa8lGA1Vte+NYeQBr+HSmZpm41dkfwLFJ0nokBzTQU0V6EksE1PM4wgc+AGNO0bzSb5dPJx6pw=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/n0zDsgxRlxSp0n0s3drloSKkBiMDssMDrpdlFMDZv4w4jgOHu
	0zqKGAVGkJEk9LNL750LukqTc0xjcnmjI5YDvN2nsv7YxWl2LunUo83gF0H5xW4k1tjZjr41pPW
	RrWNW5FLA3CBkgIfNlEEv9PMlmylYX3w=
X-Gm-Gg: AYBFou0UchsqYlQ3a/pj0wPjGAT8s281omWMcl0txHDDtWI+bt6LK6dO/RgcrcGdOiB
	31Eff4vkcurkjL+DZdrWiOIgRNP+DnJBBEzBL5XJJtk91GV1LmbGijx1rsZ0GFN73TTY914oiJd
	545txarSQP9e+pRmJRkhCs9Lp7dzjKU1oaR3Vc9VrgvgAn2RCA5Drh+O+0TKqwx+be0lQCrBCQn
	I7OtvNMp4q/7WPmTqfD5u/hCLkDcZchmTOMcqh3k8Pru1A13r7fAOYHrHiOHcucC5JiBa8LgIHj
	nzGgqQubMB3oNBlWV2l2gvyHBikLkow2aiP++A6cdk6mIDVLWTrHBmz3CPGqMbCxyWPCjxM0gmZ
	iMfbtu6ruIpdvq2Yr7XNacu7tOzIAYHd1lN0tQw==
X-Received: by 2002:a05:6808:4f61:b0:55c:836:597e with SMTP id
 5614622812f47-5640dd5ca51mr14606352b6e.31.1793870361392; Thu, 05 Nov 2026
 01:19:21 -0800 (PST)
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
References: <20260930111813.52396-1-chou.cosmo@gmail.com>
In-Reply-To: <20260930111813.52396-1-chou.cosmo@gmail.com>
From: Cosmo Chou <chou.cosmo@gmail.com>
Date: Thu, 5 Nov 2026 17:18:45 +0800
X-Gm-Features: AclHuK81XJ96pBCTYU7-hDy4yf8gIUQ_g9ciWuO0heyn1wGR422e790m2Wvg4ZU
Message-ID: <CAOeEDyuRboYqBUOtLke=X0F66_A8NCHanc2iXt91duLRFGSU9A@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] ARM: dts: aspeed: bletchley: Cleanups and second
 source devices
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au, 
	andrew@codeconstruct.com.au
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	cosmo.chou@quantatw.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Andrew,

Gentle ping on this v3 series.

Thanks,
Cosmo

On Wed, Sep 30, 2026 at 7:19=E2=80=AFPM Cosmo Chou <chou.cosmo@gmail.com> w=
rote:
>
> This series resolves dt-check-style warnings, sorts I2C nodes,
> and adds second-source RTC/LED support for the Bletchley.
>
> Changes in v3:
> - memory@80000000: keep "device_type" first, per dts-coding-style.rst.
> - Link to v2: https://lore.kernel.org/all/20260729114312.3947300-1-chou.c=
osmo@gmail.com/
>
> Changes in v2:
> - Added patches to sort I2C nodes and fix DTS coding style issues.
> - Carried over the second-source RTC and LED patches from v1.
> - Link to v1: https://lore.kernel.org/all/20260714120816.1504058-1-chou.c=
osmo@gmail.com/
>
> Cosmo Chou (4):
>   ARM: dts: aspeed: bletchley: Sort i2c device nodes by address
>   ARM: dts: aspeed: bletchley: Fix style warnings
>   ARM: dts: aspeed: bletchley: Add second source PCA9532 LED controllers
>   ARM: dts: aspeed: bletchley: Add second source ISL1208 RTC
>
>  .../aspeed/aspeed-bmc-facebook-bletchley.dts  | 1315 +++++++++++------
>  1 file changed, 902 insertions(+), 413 deletions(-)
>
> --
> 2.43.0
>


Return-Path: <linux-aspeed+bounces-4842-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9BAC5DF9C
	for <linux-aspeed@archiver.kernel.org>; Mon, 24 Aug 2026 23:44:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hTSDC3F1Cz2yFW;
	Tue, 25 Aug 2026 09:43:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787585018;
	cv=none; b=gmTfQJRM9eHbu5JrxYmY9oUgjOZXCKCRbp3Jdp/23I3VYEhIzSXzGCW3o6PlEp7GmWso9pawNdGZzoCStWcMvMlLDhTEC9PqUzeDuXwb1LVnoZDNNB23AQAc3X+enj62QfNQj6oyIuHBbTy6fmonH8YggDIq+FG7xTx3y7/rNhRrCrN7pnqGaybOXj8R22Arisy6dO0GYl3BQHjWi7ZFFvBd0VLdCus98pBulZ7N/lFPwpkkhqXlNYrBpx4jtx8SK3Q01nQFknOgRvZ6RPY49MGLspXpdp2fSLOSpG6g/iZC7oIjw24JH25JtJbPpy2y5zxK3U9SJtZlxXZrewYyTg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787585018; c=relaxed/relaxed;
	bh=hyWMUGGCNpdQSR+UOCnNr9F3b3WrWX6YNL1yYdbXEgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UGgz4WGLuJE8ybxjmUgtrnD1ML7SaIkHLF315tAcnAtEYp6BCRhvIkrrbEKMGmY665Zs7+H/1x0oo+3uaVVMPcjAutdrQisI783CTFxsz+ZzjUEfcL3wqw1Y5odwpxiiPSklehpgfNEGwnx1XIjkWG5wVEWQRKyXUtUlTj7cQ/pmezaoW5x7gUdYxApbVvZF5HYa8820JXcI22e2mURnqoFIJNpe/usFZM7J5d62PcO+hUWC+WBsuHksBv6Q33kugtyRnTpVXIIqqpJBq57ieRyUzNhm0ypiPRbfAy/eQwFcWN92lclZeveYBkVCLlop23kOY85ij+KQXp9Efz8JVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GjdIR1wr; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GjdIR1wr; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bmasney@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GjdIR1wr;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GjdIR1wr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bmasney@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hTF6x4Hfpz2xnQ
	for <linux-aspeed@lists.ozlabs.org>; Tue, 25 Aug 2026 01:23:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787585012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hyWMUGGCNpdQSR+UOCnNr9F3b3WrWX6YNL1yYdbXEgo=;
	b=GjdIR1wrlljmRwfJk3l5VXV7fTfNcfmGg7Z4+RC0+1CRg7e0YTSfJSE7hYaNG6Jc9aSkwi
	YQjfAEIBGXO/WfvWRMO+fo6ujiLiO6m6/sjfTgby207P3xXL0ajMotF0yxuq7SEWrXxkLw
	TcdPGYwcCfowog/++IRfoMqawln7fV0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787585012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hyWMUGGCNpdQSR+UOCnNr9F3b3WrWX6YNL1yYdbXEgo=;
	b=GjdIR1wrlljmRwfJk3l5VXV7fTfNcfmGg7Z4+RC0+1CRg7e0YTSfJSE7hYaNG6Jc9aSkwi
	YQjfAEIBGXO/WfvWRMO+fo6ujiLiO6m6/sjfTgby207P3xXL0ajMotF0yxuq7SEWrXxkLw
	TcdPGYwcCfowog/++IRfoMqawln7fV0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-GbW8oiwQMXKh2Z5dVI7g0A-1; Mon, 24 Aug 2026 11:23:30 -0400
X-MC-Unique: GbW8oiwQMXKh2Z5dVI7g0A-1
X-Mimecast-MFC-AGG-ID: GbW8oiwQMXKh2Z5dVI7g0A_1787585010
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5276aa86d00so40891551cf.2
        for <linux-aspeed@lists.ozlabs.org>; Mon, 24 Aug 2026 08:23:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787585010; x=1788189810;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hyWMUGGCNpdQSR+UOCnNr9F3b3WrWX6YNL1yYdbXEgo=;
        b=nL0rIDI5HRNtKII4r8ypQkWULpuJRMAXzm4KEclg3mP9zgQ5Y2vbqWeuSTK+Msh5Oz
         rLW8EQaPv+h3TreQHrvCA2iVVSGF3EG1iXyDhjSPeE9avXThW8QBUSv/tFwO9IQFzXhU
         xgA3H/Zd05IAIGTkcINGvnUU5Sb8GPEB0sCEAnIqtrfge3ahdzrV+zC90ZSFYrG2pMAN
         8TV2rHdrs50/Dz3ZPWqa7FlfFIHUrfYe6p4Y5xpEn0xz6+NC5Nd1i0isxJVb9+424DQk
         ul/KRaGBX/RfJdf5I6ziY3mZmam4/WHQb2zbYrtT80Eb393VTBI9mbD7rcKd3U1iF48c
         WsTQ==
X-Forwarded-Encrypted: i=1; AHgh+RoEzN/QzSOxW6iPHZoSqUD+IvnFgiimmhzd6+UtjF9Q8TFXq9WEsxlS/181KtxXJ2ruGYFgIymf5reAFKI=@lists.ozlabs.org
X-Gm-Message-State: AFuF++k/a8QTC7HhgW/AoMZ4kaPadwil4dxbPmG0fyew9vlXMzeKCfaT
	tMst7Dn++gqP1m7Nr2JzceJz/vAtIeJImCURGWO0CJDeBVRsfzQyIRZbEAaNTH721BxsIBp2UuV
	ncpFYZ4kNbq8w8CjYq5Kz3Touj3Yxr/iNCopUdzpHjBXRCOBL5UFchA341SAF33i3EYk=
X-Gm-Gg: AR+sD13+4I8Vz+jxEuVtkCMMUHbmzKeuUwul/bUttCRM6R65Me2UippkELtIwmxxCyp
	OwUP8eQhwWd+TDjhOEWC9htjThKKIENcnMWmqUlXa/NgOYoEUPPVAERsP6flPoaCvNPPsS6S3Sx
	w5DIi2HYZQm/Fb3ToHrbxwX1a5RGI6wYPpDR0iYgI8wqsBlZo6GKlOFKMw2Hn6YugO1tN4Rholo
	SWnyBxQ2WbddqlykwgNhBc7hdRWjsLvDN6oKxWK+fAANx/lN+Uyw/kqep8WPpjBTeno368pgRlW
	ns5397AdG0WYw4hPJIJXf7Aj1HrKm6duNI7qqU+R/Fxx45QDhOg4D1u2pWTPhmc61Phz2tWFsUR
	zaqPfF8WaqcwJo1tXYyN7I4Yoh+ExUqe6SL4=
X-Received: by 2002:ac8:7f46:0:b0:52d:78c9:9379 with SMTP id d75a77b69052e-52df5a4a524mr291839181cf.30.1787585009853;
        Mon, 24 Aug 2026 08:23:29 -0700 (PDT)
X-Received: by 2002:ac8:7f46:0:b0:52d:78c9:9379 with SMTP id d75a77b69052e-52df5a4a524mr291838151cf.30.1787585009336;
        Mon, 24 Aug 2026 08:23:29 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c9393202esm65764626d6.27.2026.08.24.08.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 08:23:28 -0700 (PDT)
Date: Mon, 24 Aug 2026 11:23:27 -0400
From: Brian Masney <bmasney@redhat.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Iwona Winiarska <iwona.winiarska@intel.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH] peci: controller: aspeed: Make sure clk_init_data is
 fully initialized
Message-ID: <aoxh76RQucnlttcA@redhat.com>
References: <48aa77c45e109f78ccd806bc3b7bf380c5bc5e71.1787240145.git.geert+renesas@glider.be>
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
In-Reply-To: <48aa77c45e109f78ccd806bc3b7bf380c5bc5e71.1787240145.git.geert+renesas@glider.be>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: t2Q_iuPxC3aGJ7lWvMqARMAlUXOKnNOAGGu7v8M6HDk_1787585010
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 21, 2026 at 12:08:05PM +0200, Geert Uytterhoeven wrote:
> The clk_init_data structure contains several mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  However,
> not initializing all members may cause subtle issues, which are only
> exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> enabled.
> 
> Make sure all members are fully initialized, to avoid such bugs, and to
> prevent future breakage when converting drivers to a different method
> for specifying the parents.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Brian Masney <bmasney@redhat.com>



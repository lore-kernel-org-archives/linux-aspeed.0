Return-Path: <linux-aspeed+bounces-5219-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61716CC6B38
	for <linux-aspeed@archiver.kernel.org>; Fri, 16 Oct 2026 15:04:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5pBY29G3z2yqw;
	Sat, 17 Oct 2026 02:04:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::72f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792163077;
	cv=none; b=mJQjDpi9M8wj3w0JLx627Iy71O9Dtp+HfVzhwKq0tPNXTirM0K2SI8pjrs4Je5ZqpBqgFD7ElYPZonFtumlv40L5VJolIhXwcLKmFOSwAd2CvLtrekyYa4sqh9r/sNCvYbzmWVoWDfexOVQCxub27AJnFbQoId2/bUN/bUoJVwau2bRz0dzybra5HzMPNYeBi4xL1okAc/QnHSexOXmSUFGgPubaUQDS61FgmNQv4uyFWaqA3uw9jDGvlo6eox0C2NBBu+zLMrV9CKs9Cfifjo6JV/6GXRMs/tleqHHVSfa/onDugXwmbEKhbI9cRdBAidfKDKRNtJwnXuBe6gVD8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792163077; c=relaxed/relaxed;
	bh=QjMVhSxuyV4C5Y9lVNWGp1YsEKYu5m2G3O2NV9TfmW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mO0bPuuQW766vOKQ8lEOsOUA4EyX5h8WIqEdo6DN+YS/SmW8JJvb47JhtCEzBVeyT7R6uHf8PxylphbfDrP5By/LEOCWh3ObIZLLDMvjY4S/jJHzCe20sh18+99YAKz7Qw72qha1nUEC28nZTFZnkY9kAojkPFzf/BYboZ4AaVQwf+hpD9Z8PPOmCnsYVCbZQdDBvTGTDxAy0rAUL6pL+PYrVzyq+RWgcUpj19C4S2J2UmBoiuXpIN8UUkSsSsK4AZ0dnUbAKmFwVblWdlD0lU39NXQeBGYR10MbDF03xjeIYzJ4W6gLhc3MzEcER1SZHpxkLkOlhC9WBx7JCo2W1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; dkim=pass (2048-bit key; unprotected) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=OmUkatAD; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::72f; helo=mail-qk1-x72f.google.com; envelope-from=stern@g.harvard.edu; receiver=lists.ozlabs.org) smtp.mailfrom=g.harvard.edu
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=OmUkatAD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=g.harvard.edu (client-ip=2607:f8b0:4864:20::72f; helo=mail-qk1-x72f.google.com; envelope-from=stern@g.harvard.edu; receiver=lists.ozlabs.org)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5pBV4N1Sz2yql
	for <linux-aspeed@lists.ozlabs.org>; Sat, 17 Oct 2026 02:04:32 +1100 (AEDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-93f1cf92c9eso4509285a.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 16 Oct 2026 08:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1792163069; x=1792767869; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QjMVhSxuyV4C5Y9lVNWGp1YsEKYu5m2G3O2NV9TfmW8=;
        b=OmUkatADiLhaQ3LyVEXFjMqqAHP6lSKGN8XJTIy2baTAzDZJ3o84uydV3blBYkSKdm
         HW0oF+L3HD/lq4e/cEJW9+D0b5TwIBY1EJTCkz2w72nNoTA9cj4s1lFx5igTyjiknSHg
         0okja77iTtZRANDO1kte5rVBpoTwu91ufdmO0g5Z41SYXZQbxna47TsogASChV9WPNgE
         NLrfLn4akQikL0ul36PP+cv1At7UAw6dH//paOYnP1UZLEjeqUSZb4Pv1SuwPS6Zb8yq
         D90VSkOG+dkrfLsm3Jra5Cbhsp6+Sr2Bmy7hr0DAvFIbFxPtamTqeEqqv59EUA9ul7BB
         QN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792163069; x=1792767869;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QjMVhSxuyV4C5Y9lVNWGp1YsEKYu5m2G3O2NV9TfmW8=;
        b=L0Zr5U4oKxyH4zt5/GmEyceqcZAgrXTilluiV/I55KW9A+0l3kG2fuYPNT1JhxnMth
         8UwMArgV/3L4hq6DI1Xs4S/YGsbuBI57bFjXGaAMbPJUdDwWQiO4kJ1CfhEJugiKsAJd
         tGHioQybx9hY8sMwXkJ6EmoIDG9/BJbmhydalKjV3k0H4mCSqW6uTa94MWjoP6IL+rJA
         thUtmAgV4yRl7Pp2zWQiKGykGtDnpqn7yCXtsjpROYj7Vgzl0li4oKTNJc7qNQKiK9Aw
         nO66Y+6wMN1aqQQzyv0ZRotHufqs+wxwm4jQi9dhTlpsErQxXPg4pMdTva9aRQr9XFd6
         BEYA==
X-Forwarded-Encrypted: i=1; AKwUvBx42+ktd2iNntd3LsJYsKKWR1vci6JlD/7Jv4mWSeAVTbWfst7OV6Fm8nsMJKUUOnFc3l746N7DVtrbyrc=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJiYco4fDZHbOhJ5m+9DUInjRW+m1wjj/er6V8FBIg2BgzxIdpH
	LLGV8NMRpdAfi9cAxoplzHwTiKs87+7Z77sHfTBZrx/gNvCj/NyOa+dBmAP5Y9GveQ==
X-Gm-Gg: AYBFou1W+CV79LFwDyD3x92Pqbi75CtEUeS8DtYzY8vplA06yv2MY5pYSK7gcBBGiKS
	5RMsm8Rt1PWBH4KWsnr0PeKa9NtwZ6X6y6tqbkHuMl3JXUIHXefnFHtynASPDXozCNp3SbuEcOm
	38AhIY5Yommuxb/Eh8/EMrxDXzGfDfItv0J/syG2OGqnaQcmWKFcfDF9VqTSICplG35laGGeswK
	6/HGdeK/m4cjSxmig50O3JoFCPzpeqsZfo5fQveQns7aFnvhduEJSmWESJt/VBnOgE3WglLvIHT
	ykgWlVkAkPvnrjRR2y1SYFnVIut+7xWM7OUkWYX3O/htfDN3Ki9wy4ZZvQSz06iTuEh+MLBY5O/
	ll4oMK+ecq0UdO9XVXALwwkaNybKZ1GFVUOTl+2EVxHG79MmbUvs1FWrroio6FEP33PmAsRFWd+
	xjXrqeR0GaAWUrGNqBYJ5xsyDKVSF5biIN4sBjcBGUnPiopjqcDIf2LpnZRpez7HIaE+W3cJI=
X-Received: by 2002:a05:620a:439b:b0:93e:e1fd:b87f with SMTP id af79cd13be357-93f29e17275mr10664485a.83.1792163068256;
        Fri, 16 Oct 2026 08:04:28 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::4791])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a1b882asm227739285a.42.2026.10.16.08.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 08:04:27 -0700 (PDT)
Date: Fri, 16 Oct 2026 11:04:24 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Joe Wang <joe_wang@aspeedtech.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-aspeed@lists.ozlabs.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: ehci: Quiesce ASPEED EHCI before halting it on
 shutdown
Message-ID: <7dfc5ef1-a466-4d78-af65-147bee8fe698@rowland.harvard.edu>
References: <20261016-upstream_ehci_aspeed_shutdown-v1-1-8440c13b5652@aspeedtech.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016-upstream_ehci_aspeed_shutdown-v1-1-8440c13b5652@aspeedtech.com>

On Fri, Oct 16, 2026 at 04:53:07PM +0800, Joe Wang wrote:
> On ASPEED EHCI controllers, clearing USBCMD.RS while both the periodic
> and asynchronous schedules are enabled may leave the controller unable
> to halt. If an asynchronous transaction is in progress when RS is
> cleared, it may run past the end of the micro-frame. The controller then
> clears its internal schedule buffer at the start of the next micro-frame
> while it is already walking the periodic schedule, issues a DMA read
> from address 0x0 and never sets USBSTS.HCHalted.
> 
> ehci_shutdown() calls ehci_silence_controller(), which halts the
> controller without first turning off the schedules. For ASPEED
> controllers, call ehci_quiesce() first to clear CMD_ASE/CMD_PSE and
> wait for STS_ASS/STS_PSS to clear, as ehci_stop() and
> ehci_bus_suspend() already do before halting. This is also the stop
> sequence recommended by ASPEED.
> 
> Quiesce the controller after setting rh_state to EHCI_RH_STOPPING.
> The asynchronous and periodic schedule-enable paths require
> EHCI_RH_RUNNING, so this ordering prevents them from restarting the
> schedules while the controller is being shut down.
> 
> Allow ehci_quiesce() to operate in EHCI_RH_STOPPING as well as
> EHCI_RH_RUNNING. As documented for enum ehci_rh_state, both states
> indicate that the controller may still be performing DMA, while
> lower states indicate that it is not.
> 
> The controller-death path in ehci_irq() also sets EHCI_RH_STOPPING
> and clears CMD_RUN, CMD_ASE and CMD_PSE. A quiesce call in that
> state writes the command register with these bits still cleared
> and polls the schedule status bits using the existing timeout
> limits, without re-enabling the controller or its schedules.
> 
> Signed-off-by: Joe Wang <joe_wang@aspeedtech.com>
> ---
> This issue was observed on a customer host platform using the AST2700
> PCIe EHCI (ehci-pci), and the root cause was confirmed by the ASPEED
> hardware team in RTL simulation. The stop sequence used here (clear
> PSE/ASE, wait for PSS/ASS to clear, then clear RS) is their
> recommended workaround and was confirmed to resolve the issue on that
> platform. All ASPEED EHCI controllers share the same design, so the
> workaround applies to every controller with is_aspeed set.
> 
> The quiesce is limited to ASPEED controllers to keep the change
> minimal for other platforms.
> 
> Tested on AST2700 (ehci-platform): ehci_shutdown() and unbind/bind
> (ehci_stop()) with a hub and USB mass storage under load, no
> regressions.

Under what circumstances does ehci_shutdown() run without ehci_stop() 
being called first?  Is controller death the only possibility?  If the 
controller is dead, will quiescing work?

Is there any real reason not to do this on all types of EHCI controller, 
not just ASPEED?

> ---
>  drivers/usb/host/ehci-hcd.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
> index 3c46bb18c7f3..d984987c8691 100644
> --- a/drivers/usb/host/ehci-hcd.c
> +++ b/drivers/usb/host/ehci-hcd.c
> @@ -274,7 +274,7 @@ static void ehci_quiesce (struct ehci_hcd *ehci)
>  {
>  	u32	temp;
>  
> -	if (ehci->rh_state != EHCI_RH_RUNNING)
> +	if (ehci->rh_state < EHCI_RH_RUNNING)
>  		return;
>  
>  	/* wait for any schedule enables/disables to take effect */
> @@ -372,6 +372,14 @@ static void ehci_shutdown(struct usb_hcd *hcd)
>  	ehci->enabled_hrtimer_events = 0;
>  	spin_unlock_irq(&ehci->lock);
>  
> +	/*
> +	 * ASPEED EHCI may never halt if RS is cleared while both schedules
> +	 * are enabled, so turn them off first. rh_state is STOPPING at this
> +	 * point, which keeps them from being re-enabled.
> +	 */
> +	if (ehci->is_aspeed)
> +		ehci_quiesce(ehci);

Don't you want to check whether the controller has already been 
quiesced?

Alan Stern

> +
>  	ehci_silence_controller(ehci);
>  
>  	hrtimer_cancel(&ehci->hrtimer);
> 
> ---
> base-commit: 2f2f7eeef8b0a1a9b9ca998231419873ccae8d4e
> change-id: 20261016-upstream_ehci_aspeed_shutdown-9ccffedb2a1c
> 
> Best regards,
> -- 
> Joe Wang <joe_wang@aspeedtech.com>
> 


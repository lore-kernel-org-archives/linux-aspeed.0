Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48DA606A319
	for <linux-aspeed@archiver.kernel.org>; Thu, 22 Oct 2026 01:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=LG7vXguk
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j98DS1Fmsz2xM7;
	Thu, 22 Oct 2026 12:47:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::f29"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792633672;
	cv=none; b=k/tTrVeo5U9ZykmiYASw4rWJO6Hk/FoOih/Iu0REEuYWp2J9aMdLgpUBc8EVrc7Z8h1JbyY0PoBnYs9zb6rRHhujY289t0+hK12mxSO3MgtuwJxFB01HYkNDJBh85mvWrCprLPlocMYgUPWdhKO1FJjH0Gdi1aQl66yV+4K7mWs9NumxVnmD+z5mnVejsWhhTKWE2WcCTYCmgo4SJRdEJ/uvquYdtxbF9+H1Fkx3AJjkPP2t5Fy4y7bdnKk+Ds/TuzxNIj8oJnl2Gl9WM5sQ9EcWuAaHHpU5qTfkR1iF8vKPVvROTsDexJbUUxCMQLiwlIQhj+KrH0OfbraqKOfjVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792633672; c=relaxed/relaxed;
	bh=gYKqhMNUDqm7sf/jtPqhDcMNm1ldVrzzvJB2Y2KBTPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hT3LKtuMuGEzLQ5HgQo65BQYtLOP7gGqlJIr+yP+hcZx+ZjNozMOv1K2jUBaQMDtMjT83s/zdslViurqMV/92h3jISmcmt/id0hVLkgn3x52yWdi9Qs83iDHXyREamPSPv2t6CnxWE4b1Gxc2Ql2Jx/bgDo5CoGK2ISAIIMKLCB16+T5KMetXbtckzSr+c07LHSxwjqcv1YMeLkm92Uj114YF1cFd9NoyijtuOkxAOaV2ue0QE994IhToVTvJnV4hA1wAeMkczm4hGj0zhF2dH/yq/1f1Q6BZncwhWakK7USoFIKMMlTFSUFKgxhfOnI+N23ShgGA/9cucDx/t0L0A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; dkim=pass (2048-bit key; unprotected) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=LG7vXguk; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f29; helo=mail-qv1-xf29.google.com; envelope-from=stern@g.harvard.edu; receiver=lists.ozlabs.org) smtp.mailfrom=g.harvard.edu
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=LG7vXguk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=g.harvard.edu (client-ip=2607:f8b0:4864:20::f29; helo=mail-qv1-xf29.google.com; envelope-from=stern@g.harvard.edu; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j98DP5DHgz2xLm
	for <linux-aspeed@lists.ozlabs.org>; Thu, 22 Oct 2026 12:47:47 +1100 (AEDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-917a64f28d0so5977326d6.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 21 Oct 2026 18:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1792633665; x=1793238465; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gYKqhMNUDqm7sf/jtPqhDcMNm1ldVrzzvJB2Y2KBTPk=;
        b=LG7vXgukgDuCHx8k/PSrm3RUxcmfvk9POQGzqKNs+FXanjQoYHhf2dBZeaPiFlgjk4
         l5Z4/EVBX5/rq71yF3v1lV0GXV/45csPGXGMRKg3wr9afNzJ61zKt8BMh81O+Ks0emfN
         W6uNrat51lM8AHUklOa2QWiCa7WUftToU2K4cCzolUs9WWtLfwG12gjogFy8eSIG0tR5
         0cvDQ8p4UihAiunq/HpO/tfitnEd5SDIZCht4AM/QHK/1aa2mEiKseB3EwJwJE4XdhYF
         Z3biGH3rn7pb26rGZZ+HhcIxxP2qLnsl9E5JZvHYNS7kq5ldCJiewlnSPcNlYZ1OrZNR
         kAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792633665; x=1793238465;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gYKqhMNUDqm7sf/jtPqhDcMNm1ldVrzzvJB2Y2KBTPk=;
        b=1hYOSDxu0OM0+5Fho/wnoFdA1fREIWlhqIKWskO///dCcIyi9OIbPGuLvwcrbTjgO8
         Ce2TyXo1s7j+SuHwctNV3o9RpYq6d3HP+HMMLN+mCrWlKBIgAABe2Z46RVVTSuJFEDh5
         vf9c/apBiDhSIzp1Q3xO1zCkZsttZQWOQLnpzk98+YendpaLywW2q4eaxy6kdYne5vwU
         UpHrePf5X7jm8IeBHIgxEyTuT5CQYUsOWpYs7xw0bSqO7/IS6oqoqKXgaF/lxtY/t3iV
         KgI+nEBaVI2DTXVfWi//R9NRf1J+cgnzWf0PJCV+IKkEJ9wRQqibWhFBh4ZPx6zq/UDz
         CDKA==
X-Forwarded-Encrypted: i=1; AKwUvBwsS19Q7qc8OPUpiOpmgQmQNVbgbbzI/YZ1F8RwIZ99uzUH7oWV/ixgMDVICGLjcdcvHUJ3hZ0hxXoi17k=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLZN0G9W+qDhFSLwVT9886eUCYITuGwmjMjXb0Am8Ez6z5Hn6jt
	s6l7ByBQEi67V6vAlxt1oyBV39KyxurNTea8MMRWEm94+K4Swa/36qlz1lHOEz1TWQ==
X-Gm-Gg: AYBFou01wrpbuImB5CXnaD1fiofx41Cf1vUlBBNHra8vaKDnSAosgqHCKrarkyAkgao
	T5+KOcYCHVY/XRqsCarHTYE8p6D5K1kdgcJAHXSpJrTSCnA983WqsW+gM1mAptLUIUb4iA5tSCh
	0cLPOoTxjElEdPXP+v0W4kHcvSJh3W+U1V32TeBto0QEJSoznUesFI/B6G587F+6PEvumtBEjuU
	Jd52UuOMZ58ZQohMp1BVbUccK+R3KFJKkFoT4kwKgxlgKdeeZOTX9SBrDJTLH7cLTidvsyJdqHl
	8D8IrEAwMhWm77agWtMA8fdFOTBBoOjVPuWSp0XnSCEZs0vSzN8xg/PawbKjCE7U/2Y3GClo5xt
	bGYeunZObshMamyAEFAY4Mi5C3CH+hbfEXGKs7gAuzxBTQ+2+nNZeDMhZH0xGf7wEcCzQX4JJza
	rOM1zJVKT8vwEm7R6iGLGDhVQjB8nhVd+M2dDKyvZ8SXUlla3NB5/Q9uhj64RPnAhbBOhf+NfV/
	E/Alw0UhnDppfWS0LGY2JbRpa3kXCnc7ou8Ka+KbkLGvndhnPcmODKM
X-Received: by 2002:a05:620a:84c4:b0:93f:16d4:3c0a with SMTP id af79cd13be357-93f6248e92emr176006185a.4.1792633664545;
        Wed, 21 Oct 2026 18:47:44 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::4791])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56e246cesm398743785a.38.2026.10.21.18.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 18:47:43 -0700 (PDT)
Date: Wed, 21 Oct 2026 21:47:39 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Joe Wang <joe_wang@aspeedtech.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-aspeed@lists.ozlabs.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: ehci: Quiesce controller before halting it on
 shutdown
Message-ID: <0acd4f35-4b99-41aa-a9c6-2764a6744c8d@rowland.harvard.edu>
References: <20261022-upstream_ehci_aspeed_shutdown-v2-1-62712169bc07@aspeedtech.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022-upstream_ehci_aspeed_shutdown-v2-1-62712169bc07@aspeedtech.com>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 09:21:11AM +0800, Joe Wang wrote:
> ehci_shutdown() runs from the .shutdown callback during reboot,
> poweroff and kexec, for example when LinuxBoot firmware boots the
> final OS. The HCD is not removed in that path, so ehci_stop() is not
> called and the controller may still be running. ehci_shutdown() then
> halts it without first turning off the schedules, leaving a DMA master
> running while the system shuts down.
> 
> On ASPEED EHCI controllers, clearing USBCMD.RS while both the periodic
> and asynchronous schedules are enabled may also leave the controller
> unable to halt. If an asynchronous transaction runs past the end of
> the micro-frame after RS is cleared, the controller walks the periodic
> schedule with a cleared internal buffer, reads from address 0x0 and
> never sets USBSTS.HCHalted.
> 
> If the controller was running, call ehci_quiesce() before halting it,
> as ehci_stop() and ehci_bus_suspend() already do. Do this after
> rh_state is set to EHCI_RH_STOPPING, so that URB submissions and
> hrtimer events cannot re-enable the schedules, and let ehci_quiesce()
> accept that state: like EHCI_RH_RUNNING, it means the controller may
> still be doing DMA. The controller-death path in ehci_irq() also sets
> EHCI_RH_STOPPING, but it has already cleared CMD_RUN, CMD_ASE and
> CMD_PSE, so a quiesce there cannot re-enable anything.
> 
> Signed-off-by: Joe Wang <joe_wang@aspeedtech.com>
> ---
> This issue was observed on a customer host platform using the AST2700
> PCIe EHCI (ehci-pci), and the root cause was confirmed by the ASPEED
> hardware team in RTL simulation. The stop sequence used here (clear
> PSE/ASE, wait for PSS/ASS to clear, then clear RS) is their
> recommended workaround and was confirmed to resolve the issue on that
> platform.
> 
> When the controller is running, the added delay at shutdown is bounded
> by the two existing 16-uframe handshakes in ehci_quiesce().
> 
> Tested on AST2700 (ehci-platform): reboot with a hub and USB mass
> storage under load, ehci_shutdown() on already halted controllers,
> and unbind/bind (ehci_stop()); no regressions.
> ---
> Changes in v2:
> - Apply to all EHCI controllers, not only ASPEED (Alan)
> - Quiesce only if the controller was running (Alan)
> - Link to v1: https://lore.kernel.org/r/20261016-upstream_ehci_aspeed_shutdown-v1-1-8440c13b5652@aspeedtech.com
> ---
>  drivers/usb/host/ehci-hcd.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

Acked-by: Alan Stern <stern@rowland.harvard.edu>

> diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
> index 3c46bb18c7f3..d9d816eedc66 100644
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
> @@ -356,6 +356,7 @@ static void ehci_silence_controller(struct ehci_hcd *ehci)
>  static void ehci_shutdown(struct usb_hcd *hcd)
>  {
>  	struct ehci_hcd	*ehci = hcd_to_ehci(hcd);
> +	bool		was_running;
>  
>  	/**
>  	 * Protect the system from crashing at system shutdown in cases where
> @@ -367,11 +368,19 @@ static void ehci_shutdown(struct usb_hcd *hcd)
>  		return;
>  
>  	spin_lock_irq(&ehci->lock);
> +	was_running = ehci->rh_state == EHCI_RH_RUNNING;
>  	ehci->shutdown = true;
>  	ehci->rh_state = EHCI_RH_STOPPING;
>  	ehci->enabled_hrtimer_events = 0;
>  	spin_unlock_irq(&ehci->lock);
>  
> +	/*
> +	 * Turn off the schedules before halting. rh_state is STOPPING now,
> +	 * so they cannot be re-enabled.
> +	 */
> +	if (was_running)
> +		ehci_quiesce(ehci);
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


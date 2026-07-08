Return-Path: <linux-aspeed+bounces-4444-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F7AC44503
	for <linux-aspeed@archiver.kernel.org>; Wed,  8 Jul 2026 23:31:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwZ9C4nV5z2yYs;
	Thu, 09 Jul 2026 09:31:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783522016;
	cv=none; b=eg24VqzgI5apSZydY0rMEQSplhxSKBU3eVHgdf9NftVQk4uBRy1qSaSC7zG65+O3n7VdLcLaINRIHheRxoiqNRItPRxf2gWJTSrTBEXwv410h4BhnLxLJAfR9UHJJjceYCx8qoeymgX1uRy/dscIF1uKTqLo/5sLaWY3o6/UHC/BdOZkDa2d2SrF2AgkH7d+NsEcp0p/uLdaVHaCs5zV/vSAAhl1Z+DN+jSyh2SHVlityE8hxEuTDBDVllKj9lPEUWIEf83Su/62JvgoJt2ymJLxKSMsa/e/hD1QUPyAqoF0doI4guwkC+VdRUECHhkTCPsTunGT9TiB4wROX9omug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783522016; c=relaxed/relaxed;
	bh=vL4MQZJyYnOZgb+t9Slt97jlU8ZMhiBcIG4lPhLxhqk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=VCcYXv+QsbF18fLpDf4/3EzN/EteFWkHRXIaseF1cu42a+b45dfDUX2dTb8WXKmdOmTfUyjp1njW528/fLmj521M9i6Cvlx1YppULjD8f/yIgD5HbuWHsOnJmpzLVY8x99g+By8WFdckdVyAUn89u2FKaaqJIlBSMlHoJ1RtjDoi+lxWMGpCNT2Ty+4op+Bgtdm59BDpKB5tkQX3uNW+TffwENNHdCJHQ47Pfh55+HvMFIN3gwm5g8jcNx5ji2hUzjZLqR7VSwtTqylBCfMbGpILg6p2Fn2b54sEflAALTMqVqWrxLguFplOk2aZStez49tqCOKwxq5DpmnVIYTWew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l9PTuMVs; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AHokzRF9; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l9PTuMVs;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AHokzRF9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwLXH2BzLz2y7r
	for <linux-aspeed@lists.ozlabs.org>; Thu, 09 Jul 2026 00:46:53 +1000 (AEST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668C39Io2736111
	for <linux-aspeed@lists.ozlabs.org>; Wed, 8 Jul 2026 14:46:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vL4MQZJyYnOZgb+t9Slt97jlU8ZMhiBcIG4lPhLxhqk=; b=l9PTuMVsLQ/lb5E7
	FUy+YKYjhfuxGpV2yPYrT8cW990iscK3mTQzOIF8tGq/IN0UGqjuAyycToz5zcmp
	b5J5Ef65ekAr1pBRTSoIVmVaCAilH9sfGD3P2WGPIs887lWUsiNiEKklxBPgWTzc
	dEcSjBxCFMfjZgSkE9LOnrD5tnmd4F1z/y65PGB1QpI4IiFBzBbHqeO8mC3y1SyT
	VijYEMNHVsbO8/EMtiW5eEhFMLHRcUpvXEZ5J4PAOgvLKXcYGSY8gNO9U3ScfM0r
	JhbjreFoT0InUzIWIFkZZMGSEQ76sA922nbzv2otnraPB1TKtoPir2rkT9lzt6gG
	mmmXMA==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9hnv1vg5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Wed, 08 Jul 2026 14:46:51 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-448d51840c4so402853fac.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 08 Jul 2026 07:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783522010; x=1784126810; darn=lists.ozlabs.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vL4MQZJyYnOZgb+t9Slt97jlU8ZMhiBcIG4lPhLxhqk=;
        b=AHokzRF9e08XEwJfThGzwoHgVmn7r+AdzJIDVLUpmbrRUIOFcfJKQklTYsKIB1OeIz
         rWmtlTEo1U/QseVXUNrgJ22lLFmi6ATiOsrX5VQrqBmLQYpURxADTiW5sOt1QqSHD2TI
         f8YH+OWCzOiOE9mM9dujypMQLtPqbd6qE5x0iNAMOdRWNGbAbAiEmOq0oYG5Vq7ESNVo
         /UXccd7Sjo1/iSkXbHfD8uI30l9K1fBwOjh0wCYuxFUOefIGGPJjAvwbm0ykxxJA042X
         UGutAhzd7OO1LYTRPvqmEpcE4NoBiIS+jxFWBR2KkSZPJETFDDspSH0zSAPnY0tv79N5
         RIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783522010; x=1784126810;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vL4MQZJyYnOZgb+t9Slt97jlU8ZMhiBcIG4lPhLxhqk=;
        b=Y2iA3GuAIdytktnS8Mp/bG9Rb23Atq32Sj6GkJ8n8CTraaltb3TxCZQIMKjg4RlZAC
         o7zyZYJ49RzVbJgyzCPJHAN8O1F9BrL/vj/O7Aafu+xZuZGu12kAc3lVdCzzHaewGt8c
         ChTMxQ4Dwj0WrG+ZPtG1E1iewwTzLWxk7EL/GEDIrKXkL/Gipo6dA3NKy3FPoIe3FxjS
         dTzazBJIfhoQnhTAvAIy/xEJAUJbj8cWATsoosAkQa6nWcl8f0LQ7lnJtutuJleWbpnF
         c/Jp7xYGuRsqIGKEzPWtgHu+Rw6J2CdP4Isv71SVbF5cNksWtD44FjGumh834Y9+RFMX
         iRgg==
X-Forwarded-Encrypted: i=1; AHgh+RoefC30L8hRDAthrVu2ZILlt29r2b2tkgZOHfLD43EC0uiaNGh8JdKeSSR0Y+I7qo2xm/n2ZbZMs0T+Vgg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzAP4Re9P7zF1dyUMCYQ0gvfV63zDZMacr2WaD4ZYOy6VOct7Pv
	S6Ea943MSxEvtFxHZ/joAVSTem7tANtIVKut/y7KuQ03wcO6niqeoIL2kmwaRDOSnCRs+FgggnV
	5ljBEVa28X+LvQ+SkqzffNMoKyHDXJlrhLnzK458+gM9kwPk6KkforVdl9eWF+1hAhM97
X-Gm-Gg: AfdE7cknAZO9/QNtrdaLU1ZxlZeEkeuThpVxAw/LXgN3aUcG9890kyu2qvPaRmacieI
	nySbRcMrJOzOD8P6e7O2/+x9+i180c5yWRw20Ejf5bbHnWnBH1VzSQ28eF1Tuc5dqEJrk+4H0kX
	NiLfZdLDbbsQp4cS74lK7h4d6UKfLjPRDHIfwVrBrVlXOh+iN5uysMx66yV33ysu42K1CA+sVxV
	J6dIjhuT9+vK47Nz8zWzWXEvelmVyyZm4b7bdSP89S/eXf+lf/lEqhJNOY6ZT1RmC003T/RsKMK
	0zmNqRAKDgtg7u5AfxaZQfqkT1kcKZoB1hANCjJ9lZ507eHqapB1tmGl1qJjHN+7w7FbAhURY7H
	g+U3NHCiPdnhGXfk=
X-Received: by 2002:a05:6871:2ecf:b0:447:a321:35d with SMTP id 586e51a60fabf-4516387345cmr1779008fac.10.1783522010287;
        Wed, 08 Jul 2026 07:46:50 -0700 (PDT)
X-Received: by 2002:a05:6871:2ecf:b0:447:a321:35d with SMTP id 586e51a60fabf-4516387345cmr1778984fac.10.1783522009770;
        Wed, 08 Jul 2026 07:46:49 -0700 (PDT)
Received: from localhost ([151.243.38.149])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44cfb13d619sm18125627fac.2.2026.07.08.07.46.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 07:46:49 -0700 (PDT)
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
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Jul 2026 22:46:30 +0800
Message-Id: <DJT9S3CQRB0P.982J925T9O4B@oss.qualcomm.com>
Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-aspeed@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>, <imx@lists.linux.dev>,
        <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 5/9] drm/pl111: replace struct drm_simple_display_pipe
 with regular atomic helpers
From: "Ze Huang" <ze.huang@oss.qualcomm.com>
To: "Thomas Zimmermann" <tzimmermann@suse.de>,
        "Ze Huang"
 <ze.huang@oss.qualcomm.com>,
        "Alexey Brodkin" <abrodkin@synopsys.com>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        "Maxime Ripard"
 <mripard@kernel.org>,
        "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>,
        "Joel Stanley" <joel@jms.id.au>,
        "Andrew Jeffery"
 <andrew@codeconstruct.com.au>,
        "Frank Li" <Frank.Li@nxp.com>,
        "Sascha
 Hauer" <s.hauer@pengutronix.de>,
        "Pengutronix Kernel Team"
 <kernel@pengutronix.de>,
        "Fabio Estevam" <festevam@gmail.com>,
        "Linus
 Walleij" <linusw@kernel.org>,
        "Hans de Goede" <hansg@kernel.org>,
        "Alex
 Lanzano" <lanzano.alex@gmail.com>,
        "Oleksandr Andrushchenko"
 <oleksandr_andrushchenko@epam.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260705-drm-simple-kms-removal-v1-0-b4e1ca053623@oss.qualcomm.com> <20260705-drm-simple-kms-removal-v1-5-b4e1ca053623@oss.qualcomm.com> <747ae980-9358-4e15-84e3-6e2f3e143423@suse.de>
In-Reply-To: <747ae980-9358-4e15-84e3-6e2f3e143423@suse.de>
X-Authority-Analysis: v=2.4 cv=KNNqylFo c=1 sm=1 tr=0 ts=6a4e62db cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=cNux22OjBTKCC6TmznXXXA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=bxtzNzRwT3Q_vXoiTiMA:9 a=QEXdDO2ut3YA:10
 a=y8BKWJGFn5sdPF1Y92-H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE0NSBTYWx0ZWRfX2y0cCp400B9J
 ZY98e+I2Rv/3HLqMwwKKkjyPwZufWZH78xizFRILAKMmy4f3UHZYlqqSQ7pOA703Sz2mY9B/4jP
 /hLrzLCa4t9B43lW43cacf0enM81S7c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE0NSBTYWx0ZWRfX2kTDy9h4vEOb
 5Y0dBPLt3EUPrUnWBl81IFT3mKnNudDJva9miz6sR5Of5Zqu7F0SGfMrVPVpBaaQ8NkSJNgIStX
 +MzsrOWqPtINOtj69cwNWyg5FS06W+ffv2zJabj4JimYwdpbXHQ8vlhivKupt9Q78gBShLmIxRi
 4krzYrRu0mMN4vicmD/UYn5VZ1m6ZSnLfJcLmiovnnMSKY7P9SLyTIBcQu3q020OhIug09lihwp
 +f6aZEecS9DKCDQuGYSQ0m8RkGSJeCF3paqeK0KAUyANNVCuHQmdIBRfEbCfAWsXZU9KVX4i2B5
 A5n7YQDixM55qkJXgzjC6/dVlTwHZhKA5HOzbwCBBPzn06Iy8iU+qFyJW41IbQFSrdVSt9wdq2M
 QkksNO+psb2F4GyUXt76miW3UW8Dg11fnxR3smhxliwj3bFxW4op03meEnEP6e1AU3A8WPtKkK8
 +Qxp/q1hp50tjvziFsQ==
X-Proofpoint-ORIG-GUID: WycjXtBKQ3-rSc4xFFpxu_Sk_eh3Essx
X-Proofpoint-GUID: WycjXtBKQ3-rSc4xFFpxu_Sk_eh3Essx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080145

On Wed Jul 8, 2026 at 9:03 PM CST, Thomas Zimmermann wrote:
>
>
> Am 04.07.26 um 20:31 schrieb Ze Huang:
>> Replace PL111 simple display pipe with explicit plane, CRTC and encoder
>> objects.
>>
>> Keep existing hardware programming and vblank behavior, and install GEM
>> framebuffer prepare helper explicitly.
>>
>> Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/pl111/pl111_display.c | 174 ++++++++++++++++++++++++++=
--------
>>   drivers/gpu/drm/pl111/pl111_drm.h     |   5 +-
>>   drivers/gpu/drm/pl111/pl111_drv.c     |   3 +-
>>   3 files changed, 136 insertions(+), 46 deletions(-)
>>

[ ... ]

>> -static int pl111_display_check(struct drm_simple_display_pipe *pipe,
>> -			       struct drm_plane_state *pstate,
>> -			       struct drm_crtc_state *cstate)
>> +static int pl111_plane_helper_atomic_check(struct drm_plane *plane,
>> +					   struct drm_atomic_commit *state)
>>   {
>> -	const struct drm_display_mode *mode =3D &cstate->mode;
>> -	struct drm_framebuffer *old_fb =3D pipe->plane.state->fb;
>> +	struct drm_plane_state *pstate =3D drm_atomic_get_new_plane_state(stat=
e, plane);
>> +	struct drm_crtc *crtc =3D pstate->crtc;
>> +	struct drm_crtc_state *cstate;
>> +	const struct drm_display_mode *mode;
>> +	struct drm_framebuffer *old_fb =3D plane->state->fb;
>>   	struct drm_framebuffer *fb =3D pstate->fb;
>> +	int ret;
>> +
>> +	if (!crtc)
>> +		return 0;
>> +
>> +	cstate =3D drm_atomic_get_new_crtc_state(state, crtc);
>> +	if (!cstate)
>> +		return 0;
>> +
>> +	ret =3D drm_atomic_helper_check_plane_state(pstate, cstate,
>> +						  DRM_PLANE_NO_SCALING,
>> +						  DRM_PLANE_NO_SCALING,
>> +						  false, false);
>
> This is another case of _check_plane_state() running conditionally.
>

Acknowledged

>> +	if (ret)
>> +		return ret;
>> +
>> +	if (!pstate->visible)
>> +		return 0;
>> +
>> +	mode =3D &cstate->mode;
>>  =20
>>   	if (mode->hdisplay % 16)
>>   		return -EINVAL;
>> @@ -117,16 +140,14 @@ static int pl111_display_check(struct drm_simple_d=
isplay_pipe *pipe,
>>   	return 0;
>>   }

[ ... ]


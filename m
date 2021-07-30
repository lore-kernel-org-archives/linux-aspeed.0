From: Winiarska, Iwona <iwona.winiarska@intel.com>
Date: Fri, 30 Jul 2021 20:13:14 +0000
Subject: [PATCH 09/14] peci: Add support for PECI device drivers
In-Reply-To: <20210729232205.GX8018@packtop>
References: <20210712220447.957418-1-iwona.winiarska@intel.com>
 <20210712220447.957418-10-iwona.winiarska@intel.com>
 <20210727201028.GS8018@packtop>
 <79f5b6ed4942ddeb66beea03907a58495376ccef.camel@intel.com>
 <20210729232205.GX8018@packtop>
Message-ID: <5476aacfd0c83fbe69c9eb2af3327ff29a03674d.camel@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2021-07-29 at 23:22 +0000, Zev Weiss wrote:
> On Thu, Jul 29, 2021 at 04:17:06PM CDT, Winiarska, Iwona wrote:
> > On Tue, 2021-07-27 at 20:10 +0000, Zev Weiss wrote:
> > > On Mon, Jul 12, 2021 at 05:04:42PM CDT, Iwona Winiarska wrote:
> > > > 
> > > > 
> > > > +#define REVISION_NUM_MASK GENMASK(15, 8)
> > > > +static int peci_get_revision(struct peci_device *device, u8 *revision)
> > > > +{
> > > > +???????struct peci_request *req;
> > > > +???????u64 dib;
> > > > +
> > > > +???????req = peci_get_dib(device);
> > > > +???????if (IS_ERR(req))
> > > > +???????????????return PTR_ERR(req);
> > > > +
> > > > +???????dib = peci_request_data_dib(req);
> > > > +???????if (dib == 0) {
> > > > +???????????????peci_request_free(req);
> > > > +???????????????return -EIO;
> > > 
> > > Any particular reason to check for zero specifically here?? It looks
> > > like that would be a case where the host CPU responds and everything's
> > > otherwise fine, but the host just happened to send back a bunch of zeros
> > > for whatever reason -- which may not be a valid PECI revision number,
> > > but if it sent back a bunch of 0xff bytes instead wouldn't that be
> > > equally invalid?
> > 
> > The response with all 0's is possible (and defined) in certain device
> > states. If
> > that happens - we don't want to continue adding the device (with "invalid"
> > revision 0), we just want to return error.
> > 
> 
> Okay, that's reasonable -- maybe worth a brief comment though.

/*
 * PECI device may be in a state where it is unable to return a proper DIB,
 * in which case it returns 0 as DIB value.
 * Let's treat this as an error to avoid carrying on with the detection using
 * invalid revision.
 */

> 
> > > 
> > > Also, given that the docs (the ones I have, at least) describe the DIB
> > > as a collection of individual bytes, dealing with it as a combined u64
> > > seems a bit confusing to me -- could we just return req->rx.buf[1]
> > > instead?
> > 
> > GetDIB returns 8-byte response, which is why we're treating it in this way
> > (similar to other commands). We're pulling out the whole response and use
> > FIELD_GET to obtain the data we need.
> > 
> 
> Sure -- but since the 8 bytes that GetDIB retrieves are a device info
> byte, a revision number byte, and six reserved bytes (at least as of the
> documentation I have access to), I'm not sure why we want to pack that
> all up into a u64 only to unpack a single byte from it a moment later
> with FIELD_GET(), when we've already got it in a convenient
> array-of-bytes form (req->rx.buf).? I could understand wanting a u64 if
> the 8 bytes were all a single value, or if it had sub-fields that
> spanned byte boundaries in awkward ways or something, but given the
> format of the response data a byte array seems like the most natural way
> of dealing with it.
> 
> I suppose it facilitates an easy zero check, but that could also be
> written as !memchr_inv(req->rx.buf, 0, 8) in the non-u64 case.

What you suggest would look like this:

static int peci_get_revision(struct peci_device *device, u8 *revision)
{
        struct peci_request *req;

        req = peci_get_dib(device);
        if (IS_ERR(req))
                return PTR_ERR(req);

        if (!memchr_inv(req->rx.buf, 0, PECI_GET_DIB_RD_LEN)) {
                peci_request_free(req);
                return -EIO;
        }
        *revision = req->rx.buf[1];

        peci_request_free(req);

        return 0;
}

Note that the caller (device.c) now needs to know read length -
PECI_GET_DIB_RD_LEN (which currently is internal to the request.c) and is
digging into rx.buf directly (rather than using helper from internal.h).

By forcing the callers to use helper functions, we can make things consistent
across various commands and avoid exporting everything to everyone using a giant
header with all definitions.

I would prefer to keep peci_get_revision() as is.

Thanks
-Iwona


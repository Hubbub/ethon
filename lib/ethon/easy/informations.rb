module Ethon
  class Easy

    # This module contains the methods to return informations
    # from the easy handle. See http://curl.haxx.se/libcurl/c/curl_easy_getinfo.html
    # for more information.
    module Informations

      # Holds available informations and their type, which is needed to
      # request the informations from libcurl.
      AVAILABLE_INFORMATIONS = {
        # Return the available http auth methods.
        :httpauth_avail => :long,

        # Return the total time in seconds for the previous
        # transfer, including name resolving, TCP connect etc.
        :total_time => :double,

        # Return the time, in seconds, it took from the start
        # until the first byte is received by libcurl. This
        # includes pretransfer time and also the time the
        # server needs to calculate the result.
        :starttransfer_time => :double,

        # Return the time, in seconds, it took from the start
        # until the SSL/SSH connect/handshake to the remote
        # host was completed. This time is most often very near
        # to the pre transfer time, except for cases such as HTTP
        # pippelining where the pretransfer time can be delayed
        # due to waits in line for the pipeline and more.
        :appconnect_time => :double,

        # Return the time, in seconds, it took from the start
        # until the file transfer is just about to begin. This
        # includes all pre-transfer commands and negotiations
        # that are specific to the particular protocol(s) involved.
        # It does not involve the sending of the protocol-
        # specific request that triggers a transfer.
        :pretransfer_time => :double,

        # Return the time, in seconds, it took from the start
        # until the connect to the remote host (or proxy) was completed.
        :connect_time => :double,

        # Return the time, in seconds, it took from the
        # start until the name resolving was completed.
        :namelookup_time => :double,

        # Return the last used effective url.
        :effective_url => :string,

        # Return the string holding the IP address of the most recent
        # connection done with this curl handle. This string
        # may be IPv6 if that's enabled.
        :primary_ip => :string,

        # Return the last received HTTP, FTP or SMTP response code.
        # The value will be zero if no server response code has
        # been received. Note that a proxy's CONNECT response should
        # be read with http_connect_code and not this.
        :response_code => :long,

        # Return the total number of redirections that were
        # actually followed
        :redirect_count => :long
      }

      AVAILABLE_INFORMATIONS.each do |name, type|
        define_method(name) do
          Curl.method("get_info_#{type}").call(name, handle)
        end
      end

      # Returns this curl version supports zlib.
      #
      # @example Return wether zlib is supported.
      #   easy.supports_zlib?
      #
      # @return [ Boolean ] True if supported, else false.
      def supports_zlib?
        !!(Curl.version.match(/zlib/))
      end
    end
  end
end